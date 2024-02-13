//
//  TrainBuddyApp.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 02.12.23.
//

import SwiftUI

let titleColor = Color(red: 164/256, green: 52/256, blue: 58/256)

@main
struct RailnetAppApp: App {
    @StateObject private var dataController = DataController()
    @State var trainStateManager = TrainStateManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TrainContentView(trainStateManager: trainStateManager)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tabItem { Label("Zug", systemImage: "train.side.front.car") }
                    .fontDesign(.rounded)
                
                SettingsContentView(trainStateManager: trainStateManager)
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
