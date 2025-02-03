//
//  CoreDataWorkerTests.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//

import XCTest
import CoreData
@testable import APODBox

final class CoreDataWorkerTests: XCTestCase {
    func testFetchByDate() {
        // Given
        let date = "2025-02-03"
        let context = NSManagedObjectContextDummy(concurrencyType: .privateQueueConcurrencyType)
        let dataManager = CoreDataManagerDummy<FavoriteMedia>(context: context)
        let repository = APODRepositoryDBDummy<FavoriteMedia>(coreDataManager: dataManager)
        let worker = CoreDataWorker(repository: repository)
        repository.fetchResult = [FavoriteMedia(context: context)]

        // When
        let result = worker.fetchByDate(date: date)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 1)
    }

    func test_FetchWithModel() {
        // Given
        let model = APODResponseModel.fixture()
        let context = NSManagedObjectContextDummy(concurrencyType: .privateQueueConcurrencyType)
        let dataManager = CoreDataManagerDummy<FavoriteMedia>(context: context)
        let repository = APODRepositoryDBDummy<FavoriteMedia>(coreDataManager: dataManager)
        repository.fetchResult = [FavoriteMedia(context: context)]
        let worker = CoreDataWorker(repository: repository)

        // When
        let result = worker.fetch(model: model)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 1)
    }

    func testSave() {
        // Given
        let context = NSManagedObjectContextDummy(concurrencyType: .privateQueueConcurrencyType)
        let dataManager = CoreDataManagerDummy<FavoriteMedia>(context: context)
        let repository = APODRepositoryDBDummy<FavoriteMedia>(coreDataManager: dataManager)
        repository.fetchResult = [FavoriteMedia(context: context)]
        let worker = CoreDataWorker(repository: repository)
        repository.saveResult = true

        // When
        let success = worker.save { _ in }

        // Then
        XCTAssertTrue(success)
        XCTAssertTrue(repository.saveCalled)
    }
}
