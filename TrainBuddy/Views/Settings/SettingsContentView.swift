//
//  SettingsContentView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 08.02.24.
//

import SwiftUI

struct SettingsContentView: View {
    @AppStorage("autoWiFiConnectOn") var autoWiFiConnectOn = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        Toggle(isOn: $autoWiFiConnectOn, label: {
                            Text("Autom. mit Zug-WLAN verbinden")
                        })
                    } header: {
                        Text("Automatisch Verbinden")
                    } footer: {
                        Text("Wenn diese Option aktiv ist, versucht sich das Gerät automatisch mit dem WLAN des Zuges zu verbinden, wenn die App geöffnet wird. Das Gerät verbindet sich nicht mit dem WLAN ohne die App zu öffnen.")
                    }

                }
            }
            .navigationTitle("Einstellungen")
        }
    }
}

#Preview {
    SettingsContentView()
}
