//
//  GalleryInteractor.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import Foundation
import CoreData

protocol GalleryBusinessLogic {
    func fetchAPOD(_ request: GalleryModels.GetMediaDay.Request)
    func saveFavorite(_ request: GalleryModels.MediaDay.Request)
}

final class GalleryInteractor: GalleryBusinessLogic {
    // MARK: - Dependencies
    private let workers: Workers

    // MARK: - Properties
    private let presenter: GalleryPresentationLogic
    private var apodModel: APODResponseModel?

    // MARK: - Inner Type
    struct Workers {
        let getAPODWorker: GetAPODWorkerProtocol
        let formatDateWorker: FormatDateWorkerProtocol
        let coreDataWorker: CoreDataWorker<FavoriteMedia>
    }

    init(
        workers: Workers,
        presenter: GalleryPresentationLogic
    ) {
        self.workers = workers
        self.presenter = presenter
    }

    func fetchAPOD(_ request: GalleryModels.GetMediaDay.Request) {
        presenter.presentLoading(.init(isActive: true))

        guard let date = request.date,
              let favorite = workers.coreDataWorker.fetchByDate(date: date)?.first else {
            fetchOnLineAPOD(request)
            return
        }

        let model = favorite.toResponseModel()
        self.apodModel = model
        self.checkFavorite()
        presenter.presentAPOD(.init(model: model))
        self.presentMediaDay(model: model)
        presenter.presentLoading(.init(isActive: false))
    }

    private func fetchOnLineAPOD(_ request: GalleryModels.GetMediaDay.Request) {
        let stringDate = workers.formatDateWorker.execute(stringDate: request.date)
        workers.getAPODWorker.execute(stringDate: stringDate) {[presenter] result in
            switch result {
            case .success(let model):
                self.apodModel = model
                self.checkFavorite()
                presenter.presentAPOD(.init(model: model))
                self.presentMediaDay(model: model)
            case .failure:
                presenter.presentError(.init())
            }
            presenter.presentLoading(.init(isActive: false))
        }
    }

    private func presentMediaDay(model: APODResponseModel) {
        guard let url = model.url else {
            return
        }

        if model.mediaType == "image" {
            presenter.presentMediaDay(.image(URL(staticString: url)))
        } else {
            presenter.presentMediaDay(.video(URL(staticString: url)))
        }
    }

    func saveFavorite(_ request: GalleryModels.MediaDay.Request) {
        var resultAction: GalleryModels.TagType = .failure
        let favorites = workers.coreDataWorker.fetch(model: apodModel)

        if let listFavorite = favorites,
           !listFavorite.isEmpty,
           let favorite = listFavorite.first(where: { favoriteMedia in
               favoriteMedia.date == apodModel?.date
           }) {
            let resultRemove = workers.coreDataWorker.delete(favorite)
            resultAction = resultRemove ? .successRemove : .failureRemove

            if resultRemove {
                presenter.presentFavorite(.init(isFavorite: false))
            }
        } else {
            let resultSave = workers.coreDataWorker.save { favorite in
                favorite.copyright = apodModel?.copyright
                favorite.date = apodModel?.date
                favorite.explanation = apodModel?.explanation
                favorite.hdurl = apodModel?.hdurl
                favorite.media_type = apodModel?.mediaType
                favorite.service_version = apodModel?.serviceVersion
                favorite.title = apodModel?.title
                favorite.url = apodModel?.url
            }
            resultAction = resultSave ? .success : .failure

            if resultSave {
                presenter.presentFavorite(.init(isFavorite: true))
            }
        }
        presenter.presentTag(resultAction)
    }

    private func checkFavorite() {
        guard let model = apodModel else {
            presenter.presentFavorite(.init(isFavorite: false))
            return
        }
        let favorites = workers.coreDataWorker.fetch(model: model)
        if let listFavorite = favorites, !listFavorite.isEmpty {
            let favorite = listFavorite.contains { favoriteMedia in
                favoriteMedia.date == model.date
            }
            presenter.presentFavorite(.init(isFavorite: favorite))
        } else {
            presenter.presentFavorite(.init(isFavorite: false))
        }
    }
}
