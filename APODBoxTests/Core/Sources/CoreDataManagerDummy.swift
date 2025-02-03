//
//  CoreDataManagerDummy.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
import Foundation
import CoreData
@testable import APODBox

class CoreDataManagerDummy<T: NSManagedObject>: CoreDataManager<T> {
    override func saveContext() -> Bool {
        return true
    }

    override func addItem(_ configure: (T) -> Void) -> Bool {
        return true
    }

    override func fetchAll() -> [T]? {
        return []
    }

    override func fetchItems(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, limit: Int? = nil) -> [T]? {
        return []
    }

    override func deleteItem(_ item: T) -> Bool {
        return true
    }

    override func fetchItem(byID id: NSManagedObjectID) -> T? {
        return nil
    }
}

class NSManagedObjectContextDummy: NSManagedObjectContext {
    var hasChangesOverride: Bool = false
    var saveCalled = false
    var fetchResult: [NSManagedObject] = []

    override var hasChanges: Bool {
        return hasChangesOverride
    }

    override func save() throws {
        saveCalled = true
    }

    override func delete(_ object: NSManagedObject) {
        
    }
}
