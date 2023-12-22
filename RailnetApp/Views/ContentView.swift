//
//  ContentView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 02.12.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var trainStateManager = TrainStateManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch(trainStateManager.appState) {
                case .Starting:
                    Text("Railnet wird gesucht...")
                case .PollingWiFi:
                    Text("Railnet wird gesucht...")
                case .FetchingInfo:
                    Text("\(trainStateManager.combinedState!.trainType) \(trainStateManager.combinedState!.lineNumber): \(trainStateManager.combinedState!.startStation) -> \(trainStateManager.combinedState!.destination.de)")
                        .bold()
                        .padding()
                    Text("Speed: \(trainStateManager.combinedState!.latestStatus.speed)")
                    Spacer()
                }
            }
            .navigationBarTitle("App")
            .onAppear(perform: trainStateManager.startSSIDPolling)
        }
    }
}

#Preview {
    ContentView()
}
