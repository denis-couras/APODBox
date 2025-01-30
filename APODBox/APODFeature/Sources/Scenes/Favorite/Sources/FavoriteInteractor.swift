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

    // MARK: - Inner Type
    struct Workers {

    }

    init(workers: Workers) {
        self.workers = workers
    }

    func fechFavorites() {

    }
}
