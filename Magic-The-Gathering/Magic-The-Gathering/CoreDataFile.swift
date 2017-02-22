//
//  CoreDataFile.swift
//  Magic-The-Gathering
//
//  Created by Sergey Nevzorov on 2/2/17.
//  Copyright © 2017 Sergey Nevzorov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataFile {
    
    private init() {
        return
    }
    
    class func getContext() -> NSManagedObjectContext {
        return CoreDataFile.persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
