//
//  NoWifiView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 06.02.24.
//

import SwiftUI

struct NoWifiView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "wifi.exclamationmark")
            Text("Verbindungsfehler")
                .bold()
                .padding()
            Text("Entweder befindest du dich nicht in einem Railjet, bist nicht mit dem WLAN des Zugs verbunden oder es ist sonst etwas schief gegangen.")
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            
            Spacer()
        }
        .navigationTitle("TrainBuddy")
        .containerRelativeFrame([.horizontal, .vertical])
        .background(backgroundColor)
    }
}

#Preview {
    NoWifiView()
}
