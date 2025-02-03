//
//  APODRepositoryDBDummy.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
import Foundation
import CoreData
@testable import APODBox

class APODRepositoryDBDummy<T: NSManagedObject>: APODRepositoryDB<T> {
    var fetchResult: [T]?
    override func fetch(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, limit: Int?) -> [T]? {
        return fetchResult
    }

    var saveResult = false
    private(set) var saveCalled = false
    override func save(_ configure: (T) -> Void) -> Bool {
        saveCalled = true
        return saveResult
    }

    override func delete(_ item: T) -> Bool {
        return true
    }
}
