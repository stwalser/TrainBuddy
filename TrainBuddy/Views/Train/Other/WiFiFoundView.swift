//
//  WiFiFoundView.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 06.02.24.
//

import SwiftUI

struct WiFiFoundView: View {
    var fetchFailed: Bool
    
    var body: some View {
        VStack {            
            Spacer()
            
            Image(systemName: "checkmark")
            Text("Railnet wurde gefunden.")
                .bold()
                .padding()
            if !fetchFailed {
                Text("Daten werden geladen...")
                    .bold()
            } else {
                Text("Laden der Daten fehlgeschlagen...")
                    .bold()
            }
            
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .navigationTitle("TrainBuddy")
    }
}

#Preview {
    WiFiFoundView(fetchFailed: false)
}
