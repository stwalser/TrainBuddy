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
    
    let backgroundColor: Color = Color(UIColor(white: 0.95, alpha: 100))
        
    var body: some View {
        VStack {
            Text(trainStateManager.getTitle())
                .font(.largeTitle)
                .padding(EdgeInsets(top: 20.0, leading: 5.0, bottom: 0.0, trailing: 5.0))
                .onAppear(perform: trainStateManager.triggerTimer)
            
            Spacer()
            
            switch(trainStateManager.connectionState) {
            case .Starting:
                
                Text("Railnet wird gesucht...")
                    .bold()
                    .padding()
                
            case .WrongWifi:
                Text("Verbindungsfehler")
                    .bold()
                
                Text("Entweder befindest du dich nicht in einem Railjet, bist nicht mit dem WLAN des Zugs verbunden oder es ist sonst etwas schief gegangen. 😬")
                    .padding()
                
            case .Fetching:
                InfoView()
                    .environmentObject(trainStateManager)
                
            case .CorrectWifi:
                Text("Railnet wurde gefunden. Daten werden geladen...")
                    .bold()
                    .padding()
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(backgroundColor)
    }
}

#Preview {
    ContentView()
}
