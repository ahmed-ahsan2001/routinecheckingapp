//
//  CoreDataManager.swift
//  RoutineCheckAppTestAssignment
//
//  Created by Muhammad Ahmed on 17/12/2024.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "routinecheckapp")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
            fatalError("Error loading Core Data: \(error)")
                   }
               }
    }
    func saveRoutine(title:String, descriptionroutine:String, date:Date , isCompleted:Bool){
        let context = persistentContainer.viewContext
        let routine = Routine(context: context)
        routine.id = UUID()
        routine.title = title
        routine.descriptionroutine = descriptionroutine
        routine.date = date
        routine.isCompleted = isCompleted
        
        do{
            try context.save()
        }catch{
            print("Error Saving routine \(error)")
        }
    }
    func fetchRoutines() -> [Routine]{
        let context = persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest <Routine> = Routine.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        }catch {
            print("Error fetching routines: \(error)")
        return []
        }
    }
}
