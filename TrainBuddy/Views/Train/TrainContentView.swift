//
//  TrainContentView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 06.02.24.
//

import SwiftUI

struct TrainContentView: View {
    @State var appContentManager: AppContentManager
    
    var body: some View {
        NavigationView {
            switch(appContentManager.connectionState) {
            case .Starting:
                CheckWiFiView(appContentManager: appContentManager)
                
            case .WrongWifi:
                NoWifiView()
                
            case .CorrectWifi:
                WiFiFoundView(fetchFailed: true)
                
            case .Fetching:
                InfoView(trainState: appContentManager.trainState!, activeConnection: true)
            case .Error:
                if appContentManager.trainState != nil {
                    InfoView(trainState: appContentManager.trainState!, activeConnection: false)
                } else {
                    WiFiFoundView(fetchFailed: false)
                }
            }
        }
    }
}

#Preview {
    @StateObject var dataController = DataController()
    
    return TrainContentView(appContentManager: AppContentManager())
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .fontDesign(.rounded)
}
