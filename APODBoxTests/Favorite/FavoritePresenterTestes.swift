//
//  FavoritePresenterTestes.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//

import XCTest
@testable import APODBox

final class FavoritePresenterTestes: XCTestCase {
    func test_PresentLoading() {
        // Given
        let (presenter, viewController) = buildSUT()

        let response = FavoriteModels.Loading.Response(isActive: true)

        // When
        presenter.presentLoading(response)

        // Then
        XCTAssertTrue(viewController.displayLoadingCalled)
        XCTAssertEqual(viewController.displayLoadingParameter?.isActive, true)
    }

    func test_PresentFavorites() {
        // Given
        let context = NSManagedObjectContextDummy(concurrencyType: .mainQueueConcurrencyType)
        let favoriteMedia = FavoriteMedia(context: context)
        favoriteMedia.title = "Title"
        favoriteMedia.date = "2025-02-03"
        let response = FavoriteModels.Favorites.Response(model: [favoriteMedia])
        let (presenter, viewController) = buildSUT()

        // When
        presenter.presentFavorites(response)

        // Then
        XCTAssertTrue(viewController.displayFavoritesCalled)
        XCTAssertEqual(viewController.displayFavoritesParameter?.model.items.count, 1)
        XCTAssertEqual(viewController.displayFavoritesParameter?.model.items.first?.title, "Title")
        XCTAssertEqual(viewController.displayFavoritesParameter?.model.items.first?.date, "2025-02-03")
    }

    func test_PresentEmptyState() {
        // Given
        let response = FavoriteModels.EmptyState.Response()
        let (presenter, viewController) = buildSUT()

        // When
        presenter.presentEmptyState(response)

        // Then
        XCTAssertTrue(viewController.displayEmptyStateCalled)
        XCTAssertEqual(viewController.displayEmptyStateParameter?.message, "Nenhum favorito encontrado!")
    }
}

extension FavoritePresenterTestes {
    typealias SUT = (
        FavoritePresenter,
        FavoriteViewControllerSpy
    )

    func buildSUT() -> SUT {
        let presenter = FavoritePresenter()
        let viewController = FavoriteViewControllerSpy()
        presenter.viewController = viewController
        return (presenter, viewController)
    }
}
