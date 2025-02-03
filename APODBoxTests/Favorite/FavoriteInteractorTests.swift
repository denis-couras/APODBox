//
//  FavoriteInteractorTests.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//

import XCTest
import CoreData
@testable import APODBox

final class FavoriteInteractorTests: XCTestCase {
    func test_FechFavorites_ShouldPresentFavorites_WhenDataExists() {
        // Given
        let favoriteMedia = FavoriteMedia()
        let presenter = FavoritePresenterSpy()
        let context = NSManagedObjectContextDummy(concurrencyType: .mainQueueConcurrencyType)
        let dataManager = CoreDataManagerDummy<FavoriteMedia>(context: context)
        let repository = APODRepositoryDBDummy<FavoriteMedia>(coreDataManager: dataManager)
        let coreWorker = CoreDataWorkerDummy<FavoriteMedia>(repository: repository)
        coreWorker.responseResult = .init([favoriteMedia])
        let workers = FavoriteInteractor.Workers(coreDataWorker: coreWorker)
        let interactor = FavoriteInteractor(workers: workers, presenter: presenter)

        // When
        interactor.fechFavorites()

        // Then
        XCTAssertTrue(presenter.presentFavoritesCalled)
        XCTAssertFalse(presenter.presentEmptyStateCalled)
        XCTAssertFalse(presenter.presentLoadingCalled)
    }

    func test_FechFavorites_ShouldPresentEmptyState_WhenNoDataExists() {
        // Given
        let presenter = FavoritePresenterSpy()
        let context = NSManagedObjectContextDummy(concurrencyType: .mainQueueConcurrencyType)
        let dataManager = CoreDataManagerDummy<FavoriteMedia>(context: context)
        let repository = APODRepositoryDBDummy<FavoriteMedia>(coreDataManager: dataManager)
        let coreWorker = CoreDataWorkerDummy<FavoriteMedia>(repository: repository)
        let workers = FavoriteInteractor.Workers(coreDataWorker: coreWorker)
        let interactor = FavoriteInteractor(workers: workers, presenter: presenter)

        // When
        interactor.fechFavorites()

        // Then
        XCTAssertFalse(presenter.presentFavoritesCalled)
        XCTAssertTrue(presenter.presentEmptyStateCalled)
        XCTAssertFalse(presenter.presentLoadingCalled)
    }
}
