//
//  ConnectionManager.swift
//  RailnetApp
//
//  Created by Stefan Walser on 08.12.23.
//

import Foundation
import NetworkExtension

class TrainStateManager: ObservableObject {
    var timer =  Timer()
    
    timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        fetchState()
    }
    
    func fetchState() {
        
    }
    
}

