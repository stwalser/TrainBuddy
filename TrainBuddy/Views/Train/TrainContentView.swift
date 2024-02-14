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
                WiFiFoundView()
                
            case .Fetching:
                InfoView(trainState: appContentManager.trainState!)
            case .Error:
                InfoView(trainState: appContentManager.trainState!)
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
