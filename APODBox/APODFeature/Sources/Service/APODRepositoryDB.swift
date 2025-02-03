//
//  APODRepositoryDB.swift
//  APODBox
//
//  Created by Denis Couras on 02/02/25.
//

import CoreData

protocol APODRepositoryDBProtocol {
    associatedtype T: NSManagedObject

    func fetchAll() -> [T]?
    func fetch(
        predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor]?,
        limit: Int?
    ) -> [T]?
    func save(_ configure: (T) -> Void) -> Bool
    func delete(_ item: T) -> Bool
}

class APODRepositoryDB<T: NSManagedObject>: APODRepositoryDBProtocol {
    private let coreDataManager: CoreDataManager<T>

    init(coreDataManager: CoreDataManager<T>) {
        self.coreDataManager = coreDataManager
    }

    func fetchAll() -> [T]? {
        coreDataManager.fetchAll()
    }

    func fetch(
        predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor]?,
        limit: Int?
    ) -> [T]? {
        coreDataManager.fetchItems(
            predicate: predicate,
            sortDescriptors: sortDescriptors,
            limit: limit
        )
    }

    func save(_ configure: (T) -> Void) -> Bool {
        return coreDataManager.addItem(configure)
    }

    func delete(_ item: T) -> Bool {
        return coreDataManager.deleteItem(item)
    }
}
