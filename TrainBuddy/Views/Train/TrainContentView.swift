//
//  TrainContentView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 06.02.24.
//

import SwiftUI

struct TrainContentView: View {
    @State var trainStateManager: TrainStateManager
    
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
            case .Error:
                InfoView(trainStateManager: trainStateManager)
            }
        }
    }
}

#Preview {
    @StateObject var dataController = DataController()
    
    return TrainContentView(trainStateManager: TrainStateManager())
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .fontDesign(.rounded)
}
