//
//  CheradesApp.swift
//  Cherades
//
//  Created by Dave Bage on 18/11/2021.
//

import SwiftUI

@main
struct CheradesApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
