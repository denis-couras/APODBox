//
//  FavoritePresenter.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

protocol FavoritePresentationLogic {
    func presentLoading(_ response: FavoriteModels.Loading.Response)
    func presentFavorites(_ response: FavoriteModels.Favorites.Response)
    func presentEmptyState(_ response: FavoriteModels.EmptyState.Response)
}

final class FavoritePresenter: FavoritePresentationLogic {
    // MARK: - Dependencies
    weak var viewController: FavoriteDisplayLogic?

    func presentLoading(_ response: FavoriteModels.Loading.Response) {
        viewController?.displayLoading(.init(isActive: response.isActive))
    }
    
    func presentFavorites(_ response: FavoriteModels.Favorites.Response) {
        let items = response.model.map { media in
            FavoriteModels.FavoriteItem(title: media.title ?? "", date: media.date ?? "")
        }
        viewController?.displayFavorites(.init(model: .init(items: items)))
    }
    
    func presentEmptyState(_ response: FavoriteModels.EmptyState.Response) {
        viewController?.displayEmptyState(.init(message: "Nenhum favorito encontrado!"))
    }
}
