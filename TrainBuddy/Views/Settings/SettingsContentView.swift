//
//  SettingsContentView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 08.02.24.
//

import SwiftUI

struct SettingsContentView: View {
    @AppStorage("liveActivitiyOn") var liveActivityOn = false
    @State var appContentManager: AppContentManager
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        Toggle(isOn: $liveActivityOn, label: {
                            Text("Live Aktivität anzeigen")
                        })
                        .onChange(of: liveActivityOn) { _, newValue in
                            if newValue {
                                appContentManager.addLiveActivity()
                            } else {
                                appContentManager.removeLiveActivity()
                            }
                        }
                    } header: {
                        Text("Live Aktivität")
                    }
                }
            }
            .navigationTitle("Einstellungen")
        }
    }
}

#Preview {
    SettingsContentView(appContentManager: AppContentManager())
}
