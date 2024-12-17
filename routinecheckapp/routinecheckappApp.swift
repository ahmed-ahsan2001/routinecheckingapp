//
//  routinecheckappApp.swift
//  routinecheckapp
//
//  Created by Muhammad Ahmed on 17/12/2024.
//

import SwiftUI
import FirebaseCore

@main
struct routinecheckappApp: App {
    init() {
        FirebaseApp.configure()
    }
    let persistenceController = PersistenceController.shared
    let vm = RoutineViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: vm)
        }
    }
}
