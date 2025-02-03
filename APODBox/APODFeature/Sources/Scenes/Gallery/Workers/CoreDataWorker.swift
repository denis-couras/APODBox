//
//  CoreDataWorker.swift
//  APODBox
//
//  Created by Denis Couras on 02/02/25.
//

import CoreData

protocol CoreDataWorkerProtocol {
    associatedtype T: NSManagedObject

    func fetch(model: APODResponseModel?) -> [T]?
    func fetchByDate(date: String) -> [T]?
    func save(_ configure: (T) -> Void) -> Bool
    func delete(_ item: T) -> Bool
}

class CoreDataWorker<T: NSManagedObject>: CoreDataWorkerProtocol {
    // MARK: - Properties
    private let repository: APODRepositoryDB<T>

    init(repository: APODRepositoryDB<T>) {
        self.repository = repository
    }

    func fetchByDate(date: String) -> [T]? {
        var predicate: NSPredicate?
        predicate = NSPredicate(format: "date == %@", "\(date)")

        return repository.fetch(
            predicate: predicate,
            sortDescriptors: nil,
            limit: nil
        )
    }

    func fetch(model: APODResponseModel?) -> [T]? {
        var predicate: NSPredicate?
        let sort = NSSortDescriptor(key: "date", ascending: false)

        if let model = model, let date = model.date {
            predicate = NSPredicate(format: "date == %@", "\(date)")
        }

        return repository.fetch(
            predicate: predicate,
            sortDescriptors: [sort],
            limit: nil
        )
    }

    func save(_ configure: (T) -> Void) -> Bool {
        repository.save(configure)
    }

    func delete(_ item: T) -> Bool {
        repository.delete(item)
    }
}
