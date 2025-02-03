//
//  CoreDataManager.swift
//  APODBox
//
//  Created by Denis Couras on 02/02/25.
//
import CoreData

class CoreDataManager<T: NSManagedObject> {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveContext() -> Bool {
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                print("Error saving context: \(error)")
                return false
            }
        }
        return true
    }

    func addItem(_ configure: (T) -> Void) -> Bool {
        let item = T(context: context)
        configure(item)
        return saveContext()
    }

    func fetchAll() -> [T]? {
        return fetchItems()
    }

    func fetchItems(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        limit: Int? = nil
    ) -> [T]? {

        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors

        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }

        do {
            let items = try context.fetch(fetchRequest)
            return items
        } catch {
            print("Error fetching items: \(error)")
            return nil
        }
    }

    func deleteItem(_ item: T) -> Bool {
        context.delete(item)
        return saveContext()
    }

    func fetchItem(byID id: NSManagedObjectID) -> T? {
        return context.object(with: id) as? T
    }
}
