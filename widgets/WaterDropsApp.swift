//
//  WaterDropsApp.swift
//  widgets
//
//  Created by Азамат Баев on 24.06.2024.
//

import SwiftUI

@main
struct WaterDropsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

