//
//  FavoriteInteractor.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

protocol FavoriteBusinessLogic {
    func fechFavorites()
}

final class FavoriteInteractor: FavoriteBusinessLogic {

    // MARK: - Dependencies
    private let workers: Workers

    // MARK: - Properties
    private let presenter: FavoritePresentationLogic

    // MARK: - Inner Type
    struct Workers {
        let coreDataWorker: CoreDataWorker<FavoriteMedia>
    }

    init(
        workers: Workers,
        presenter: FavoritePresentationLogic
    ) {
        self.workers = workers
        self.presenter = presenter
    }

    func fechFavorites() {
        presenter.presentLoading(.init(isActive: true))
        let favorites = workers.coreDataWorker.fetch(model: nil)

        if let favorites = favorites, !favorites.isEmpty {
            presenter.presentFavorites(.init(model: favorites))
        } else {
            presenter.presentEmptyState(.init())
        }

        presenter.presentLoading(.init(isActive: false))
    }
}
