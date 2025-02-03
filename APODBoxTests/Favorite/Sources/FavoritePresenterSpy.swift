//
//  FavoritePresenterSpy.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
@testable import APODBox

final class FavoritePresenterSpy: FavoritePresentationLogic {
    var presentLoadingCalled = false
    var presentFavoritesCalled = false
    var presentEmptyStateCalled = false
    
    func presentLoading(_ response: FavoriteModels.Loading.Response) {
        presentLoadingCalled = response.isActive
    }
    
    func presentFavorites(_ response: FavoriteModels.Favorites.Response) {
        presentFavoritesCalled = true
    }
    
    func presentEmptyState(_ response: FavoriteModels.EmptyState.Response) {
        presentEmptyStateCalled = true
    }
}
