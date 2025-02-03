//
//  GalleryInteractorTests.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//

import XCTest
import CoreData
@testable import APODBox

final class GalleryInteractorTests: XCTestCase {
    func test_FetchAPOD_WithCoreData() {
        // Given
        let presenter = GalleryPresenterSpy()
        let request = GalleryModels.GetMediaDay.Request(date: "2025-02-03")
        let context = NSManagedObjectContextDummy(concurrencyType: .mainQueueConcurrencyType)
        let dataManager = CoreDataManagerDummy<FavoriteMedia>(context: context)
        let repository = APODRepositoryDBDummy<FavoriteMedia>(coreDataManager: dataManager)
        let coreWorker = CoreDataWorkerDummy<FavoriteMedia>(repository: repository)
        let workers = GalleryInteractor.Workers(
            getAPODWorker: GetAPODWorkerDummy(),
            formatDateWorker: FormatDateWorkerDummy(),
            coreDataWorker: coreWorker
        )
        let interactor = GalleryInteractor(workers: workers, presenter: presenter)
        let favoriteMedia = FavoriteMedia(context: context)
        coreWorker.responseResult = [favoriteMedia]

        // When
        interactor.fetchAPOD(request)

        // Then
        XCTAssertTrue(presenter.presentLoadingCalled)
        XCTAssertTrue(presenter.presentAPODCalled)
        XCTAssertTrue(presenter.presentFavoriteCalled)
    }
}
