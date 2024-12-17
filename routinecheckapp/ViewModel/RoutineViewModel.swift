//
//  RoutineViewModel.swift
//  RoutineCheckAppTestAssignment
//
//  Created by Muhammad Ahmed on 17/12/2024.
//

import Combine
import Foundation
class RoutineViewModel: ObservableObject {
    @Published var routines: [Routine] = []
    
    func loadRoutines() {
            FirebaseManager.shared.fetchRoutines { fetchedRoutines in
                DispatchQueue.main.async {
                    self.routines = fetchedRoutines
                }
            }
        }
    
    func addRoutine(title: String, descriptionroutine: String, date: Date) {
        CoreDataManager.shared.saveRoutine(title: title, descriptionroutine: descriptionroutine, date: date, isCompleted: false)
        FirebaseManager.shared.uploadRoutine(routine: routines.last!)
        loadRoutines()
    }
}
