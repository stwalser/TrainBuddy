//
//  TrainCommunicator.swift
//  TrainBuddy
//
//  Created by Stefan Walser on 13.02.24.
//

import Foundation

class TrainCommunicator {
    let url: URL
    
    init(for company: Company) {
        self.url = URL(string: companyDict[company.rawValue]!["contentURL"]! as! String)!
    }
    
    func fetchCombinedState() async throws -> CombinedState {
#if targetEnvironment(simulator)
        if let url = Bundle.main.url(forResource: "combined-2", withExtension: ".json") {
            let json = try Data(contentsOf: url)
            return try JSONDecoder().decode(CombinedState.self, from: json)
        }
        throw CombinedStateError.decodeError("File")
#else
        let urlRequest = URLRequest(url: self.url)
        let urlSession = URLSession.shared
        urlSession.configuration.waitsForConnectivity = true

        let (json, _) = try await urlSession.data(for: urlRequest)
        
        return try JSONDecoder().decode(CombinedState.self, from: json)
#endif
    }
}
