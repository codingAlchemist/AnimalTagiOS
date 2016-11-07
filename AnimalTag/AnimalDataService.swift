//
//  AnimalDataService.swift
//  AnimalTag
//
//  Created by jason debottis on 11/7/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import Foundation
import CoreData
class AnimalDataService {
    
    public static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    public static func storeSavedAnimal(animalIn: Animal) -> Void {
        let context = getContext()
        
        let animal = NSEntityDescription.entity(forEntityName: "SavedAnimal", in: context)
        
        let savedAnimal = NSManagedObject(entity: animal!, insertInto: context)
        
        savedAnimal.setValue(animalIn.commonName, forKey: "commonName")
        savedAnimal.setValue(animalIn.scientificName, forKey: "scientificName")
        savedAnimal.setValue(animalIn.naturalHistory, forKey: "naturalHistory")
        savedAnimal.setValue(animalIn.image1, forKey: "image1")
        savedAnimal.setValue(animalIn.image2, forKey: "image2")
        savedAnimal.setValue(animalIn.image3, forKey: "image3")
        
        //save
        do{
            try context.save()
            print("Animal Saved")
        }catch let error as NSError{
            print("Could not save \(error)")
        }
    }
    
    public static func getTranscriptions() -> Void {
        let fetchRequest: NSFetchRequest<SavedAnimal> = SavedAnimal.fetchRequest()
        
        do{
            let searchResults = try getContext().fetch(fetchRequest)
            
            print("Results count:\(searchResults.count)")
            
            for animal in searchResults as [NSManagedObject]{
                print("\(animal.value(forKey: "commonName"))")
            }
        }catch{
            print("Error with request: \(error)")
        }
    }
}
