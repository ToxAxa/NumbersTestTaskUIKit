//
//  CoreDataHelper.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import UIKit
import CoreData

class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }()
    
    lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = mainManagedObjectContext
        
        return privateContext
    }()
    
    private func saveMainContext(completion: Action) {
        if mainManagedObjectContext.hasChanges {
            do {
                try mainManagedObjectContext.save()
                print("SAVED")
                completion()
            } catch {
                print("Error saving main managed object context: \(error)")
            }
        }
    }
    
    func savePrivateContext() {
        if privateManagedObjectContext.hasChanges {
            do {
                try privateManagedObjectContext.save()
            } catch {
                print("Error saving private managed object context: \(error)")
            }
        }
    }
    
    func saveChanges(completion: Action) {
        savePrivateContext()
        
        mainManagedObjectContext.performAndWait {
            saveMainContext(completion: completion)
        }
    }

    func saveData<T: NSManagedObject>(objects: [T], completion: @escaping Action) {
        
        privateManagedObjectContext.perform {

            for object in objects {
                self.privateManagedObjectContext.insert(object)
            }
            
            self.saveChanges(completion: completion)
        }
    }
}

