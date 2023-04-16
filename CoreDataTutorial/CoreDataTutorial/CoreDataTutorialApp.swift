//
//  CoreDataTutorialApp.swift
//  CoreDataTutorial
//
//  Created by Javier Rodríguez Gómez on 31/3/22.
//

import SwiftUI

@main
struct CoreDataTutorialApp: App {
    let persistanceController = PersistanceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistanceController.container.viewContext)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                print("Scene is in background")
                persistanceController.save()
            case .inactive:
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Apple must have changed something")
            }
        }
    }
}
