//
//  CoreDataService.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 15.09.2025.
//

import Foundation
import CoreData

final class CoreDataService {
    
    //MARK: - Save
    func saveNumber(from model: NumberInfoModel, completion: @escaping Action) {
        guard let newNumber = NSEntityDescription.insertNewObject(forEntityName: "NumberInfoData", into: CoreDataHelper.shared.privateManagedObjectContext) as? NumberInfoData else {return}
        
        newNumber.id = model.id
        newNumber.title = model.number
        newNumber.descriptionNumber = model.description
        
        CoreDataHelper.shared.saveData(objects: [newNumber], completion: completion)
    }
    
    //MARK: - Get All
    func retrieveAllnumbers() -> [NumberInfoData] {
        let fetchRequest: NSFetchRequest<NumberInfoData> = NumberInfoData.fetchRequest()
        
        var numbers = [NumberInfoData]()
        
        CoreDataHelper.shared.mainManagedObjectContext.performAndWait {
            do {
                numbers = try CoreDataHelper.shared.mainManagedObjectContext.fetch(fetchRequest)
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        return numbers
    }
    
    //MARK: - Get Current
    func retrieveNumber(byId id: String) -> NumberInfoData? {
        let fetchRequest: NSFetchRequest<NumberInfoData> = NumberInfoData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.fetchLimit = 1
        
        var number = [NumberInfoData]()
        CoreDataHelper.shared.mainManagedObjectContext.performAndWait {
            do {
                number = try CoreDataHelper.shared.mainManagedObjectContext.fetch(fetchRequest)
            } catch {
                print("Error fetching specific code data: \(error)")
            }
        }
        
        return number.first
    }
}
