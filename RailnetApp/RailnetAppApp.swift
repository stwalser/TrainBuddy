//
//  RailnetAppApp.swift
//  RailnetApp
//
//  Created by Stefan Walser on 02.12.23.
//

import SwiftUI

@main
struct RailnetAppApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
