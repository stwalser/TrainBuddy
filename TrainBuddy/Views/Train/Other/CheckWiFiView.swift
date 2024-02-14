//
//  CHeckWiFiView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 06.02.24.
//

import SwiftUI

struct CheckWiFiView: View {
    @State var appContentManager: AppContentManager
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "magnifyingglass")
            
            Text("Railnet wird gesucht...")
                .bold()
                .padding()
            
            Spacer()
        }
        .navigationTitle("TrainBuddy")
        .onAppear(perform: appContentManager.triggerTimer)
    }
}

#Preview {
    CheckWiFiView(appContentManager: AppContentManager())
}
