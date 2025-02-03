//
//  CoreDataWorkerDummy.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
import Foundation
import CoreData
@testable import APODBox

final class CoreDataWorkerDummy<T: NSManagedObject>: CoreDataWorker<T> {
    var responseResult: [T]?
    override func fetch(model: APODBox.APODResponseModel?) -> [T]? {
        return responseResult
    }

    override func fetchByDate(date: String) -> [T]? {
        return responseResult
    }

    override func save(_ configure: (T) -> Void) -> Bool {
        return true
    }

    override func delete(_ item: T) -> Bool {
        return true
    }
}
