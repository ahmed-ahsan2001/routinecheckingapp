//
//  FirebaseManager.swift
//  RoutineCheckAppTestAssignment
//
//  Created by Muhammad Ahmed on 17/12/2024.
//

import Foundation
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    
    func uploadRoutine(routine: Routine) {
        let routineId = UUID().uuidString
        let routineData: [String: Any] = [
            "id": routineId,
            "title": routine.title ?? "",
            "descriptionroutine": routine.descriptionroutine ?? "",
            "date": routine.date ?? Date(),
            "isCompleted": routine.isCompleted
        ]
        
        db.collection("routines").document(UUID().uuidString).setData(routineData) { error in
            if let error = error {
                print("Error uploading to Firebase: \(error)")
            }
            print("sucessfully added in firebase \(routineData)")
        }
    }
    
    func fetchRoutines(completion: @escaping ([Routine]) -> Void) {
        db.collection("routines").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching routines: \(error)")
                completion([])
            } else {
                var routines: [Routine] = []
                snapshot?.documents.forEach { document in
                    let data = document.data()
                    let routine = Routine(context: CoreDataManager.shared.persistentContainer.viewContext)
                    routine.id = UUID(uuidString: data["id"] as? String ?? "")
                    routine.title = data["title"] as? String
                    routine.descriptionroutine = data["descriptionroutine"] as? String ?? ""
                    routine.date = data["date"] as? Date
                    routine.isCompleted = data["isCompleted"] as? Bool ?? false
                    routines.append(routine)
                }
                completion(routines)
            }
        }
    }
}
