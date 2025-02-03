//
//  GalleryPresenter.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

protocol GalleryPresentationLogic {
    func presentError(_ response: GalleryModels.Error.Response)
    func presentLoading(_ response: GalleryModels.Loading.Response)
    func presentAPOD(_ response: GalleryModels.APOD.Response)
    func presentMediaDay(_ response: GalleryModels.Media.Response)
    func presentTag(_ response: GalleryModels.Tag.Response)
    func presentFavorite(_ response: GalleryModels.Favorite.Response)
}

final class GalleryPresenter: GalleryPresentationLogic {
    // MARK: - Dependencies
    weak var viewController: GalleryDisplayLogic?

    func presentLoading(_ response: GalleryModels.Loading.Response) {
        viewController?.displayLoading(.init(isActive: response.isActive))
    }

    func presentAPOD(_ response: GalleryModels.APOD.Response) {
        guard let title = response.model.title,
              let explanation = response.model.explanation,
              let date = response.model.date
        else { return }
        viewController?.displayAPOD(.init(
            title: title,
            explanation: explanation,
            copyright: response.model.copyright ?? "",
            date: date
        ))
    }

    func presentMediaDay(_ response: GalleryModels.Media.Response) {
        switch response {
        case .image(let url):
            viewController?.displayImageDay(.init(url: url))
        case .video(let url):
            viewController?.displayVideoDay(.init(url: url))
        }
    }
    func presentError(_ response: GalleryModels.Error.Response) {
        viewController?.displayError(.init())
    }

    func presentTag(_ response: GalleryModels.Tag.Response) {
        switch response {
        case .success:
            viewController?.displayTagSuccess(.init(
                message: "Sucesso ao adicionar aos Favoritos",
                type: response
            ))
        case .failure:
            viewController?.displayTagFailure(.init(
                message: "Erro ao adicionar dos Favoritos",
                type: response
            ))
        case .successRemove:
            viewController?.displayTagSuccess(.init(
                message: "Sucesso ao remover dos Favoritos",
                type: response
            ))
        case .failureRemove:
            viewController?.displayTagFailure(.init(
                message: "Erro ao remover dos Favoritos",
                type: response
            ))
        }
    }

    func presentFavorite(_ response: GalleryModels.Favorite.Response) {
        viewController?.displayFavorite(.init(isFavorite: response.isFavorite))
    }
}
