//
//  TrainBuddyApp.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 02.12.23.
//

import SwiftUI

let backgroundColor: Color = Color(UIColor(white: 0.95, alpha: 100))

@main
struct RailnetAppApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TrainContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tabItem { Label("Zug", systemImage: "train.side.front.car") }
                    .fontDesign(.rounded)
                
                SettingsContentView()
                    .tabItem { Label("Einstellungen", systemImage: "gear") }
            }
        }
    }
}

@ViewBuilder func titleBuilder(_ title: String) -> some View {
    Text(title)
        .font(.largeTitle)
        .padding(EdgeInsets(top: 20.0, leading: 5.0, bottom: 0.0, trailing: 5.0))
}
