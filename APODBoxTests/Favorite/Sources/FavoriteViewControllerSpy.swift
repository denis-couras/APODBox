//
//  FavoriteViewControllerSpy.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
@testable import APODBox

class FavoriteViewControllerSpy: FavoriteDisplayLogic {
    var displayLoadingCalled = false
    var displayLoadingParameter: FavoriteModels.Loading.ViewModel?

    var displayFavoritesCalled = false
    var displayFavoritesParameter: FavoriteModels.Favorites.ViewModel?

    var displayEmptyStateCalled = false
    var displayEmptyStateParameter: FavoriteModels.EmptyState.ViewModel?

    func displayLoading(_ viewModel: FavoriteModels.Loading.ViewModel) {
        displayLoadingCalled = true
        displayLoadingParameter = viewModel
    }

    func displayFavorites(_ viewModel: FavoriteModels.Favorites.ViewModel) {
        displayFavoritesCalled = true
        displayFavoritesParameter = viewModel
    }

    func displayEmptyState(_ viewModel: FavoriteModels.EmptyState.ViewModel) {
        displayEmptyStateCalled = true
        displayEmptyStateParameter = viewModel
    }
}
