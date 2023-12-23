//
//  ContentView.swift
//  RailnetApp
//
//  Created by Stefan Walser on 02.12.23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var trainStateManager = TrainStateManager()
    
    var body: some View {
        switch(trainStateManager.connectionState) {
        case .Starting:
            
            Text("Railnet wird gesucht...")
                .bold()
                .padding()
            
        case .WrongWifi:
            Text("Verbindungsfehler")
                .bold()
                .padding()
            
            Text("Entweder befindest du dich nicht in einem Railjet, bist nicht mit dem WLAN des Zugs verbunden oder es ist sonst etwas schief gegangen. 😬")
                .padding()
            
        case .Fetching:
            InfoView().environmentObject(trainStateManager)
            
        case .CorrectWifi:
            Text("Railnet wurde gefunden. Daten werden geladen...")
                .bold()
                .padding()
        }
    Spacer()
        .onAppear(perform: trainStateManager.triggerTimer)
    }
}

#Preview {
    ContentView()
}
