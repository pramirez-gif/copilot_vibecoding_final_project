//
//  FinalProjectVibecodingApp.swift
//  FinalProjectVibecoding
//
//  Created by Pablo Ramirez on 26/05/26.
//

import SwiftUI
import SwiftData

@main
struct FinalProjectVibecodingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            // Mostrar módulo de Noticias como vista inicial
            NewsModuleView()
        }
        .modelContainer(sharedModelContainer)
    }
}
