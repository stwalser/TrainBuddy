//
//  TrainContentView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 06.02.24.
//

import SwiftUI

struct TrainContentView: View {
    @State var trainStateManager = TrainStateManager()
    @AppStorage("showWiFiAutoConnectAlert") var showWiFiAutoConnectAlert = true
    @AppStorage("autoWiFiConnectOn") var autoWiFiConnectOn = false
    
    var body: some View {
        NavigationView {
            switch(trainStateManager.connectionState) {
            case .Starting:
                CheckWiFiView(trainStateManager: trainStateManager)
                
            case .WrongWifi:
                NoWifiView()
                
            case .CorrectWifi:
                WiFiFoundView()
                
            case .Fetching:
                InfoView(trainStateManager: trainStateManager)
            }
        }
        .alert("Automatisch mit Zug-WLAN verbinden", isPresented: $showWiFiAutoConnectAlert) {
            Button("Ja") {
                autoWiFiConnectOn = true
            }
            
            Button(role: .cancel) {
                autoWiFiConnectOn = false
            } label: {
                Text("Nein")
            }
        } message: {
            Text("Soll TrainBuddy, wenn dein Gerät nicht mit dem Zug-WLAN verbunden ist, beim Start der App versuchen das Gerät mit dem Zug-WLAN zu verbinden? Diese Einstellung kann jederzeit geändert werden.")
        }
    }
}

#Preview {
    @StateObject var dataController = DataController()
    
    return TrainContentView()
        .environment(\.managedObjectContext, dataController.container.viewContext)
}
