//
//  PersistenceManager.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import CoreData

class PersistenceManager: NSObject {

    static let sharedInstance = PersistenceManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RedditAppDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetch<T: NSManagedObject>(_ objectType: T.Type, sortBy: String, ascending: Bool) -> [T] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: objectType))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortBy, ascending: ascending)]

        do {
            let fetchedObjects = try persistentContainer.viewContext.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return [T]()
        }
    }

    func fetchById<T: NSManagedObject>(_ objectType: T.Type, id: String) -> [T] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: objectType))
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let fetchedObjects = try persistentContainer.viewContext.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return [T]()
        }
    }
}

