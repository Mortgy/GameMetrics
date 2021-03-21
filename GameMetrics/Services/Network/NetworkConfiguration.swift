//
//  NetworkConfiguration.swift
//  GameMetrics
//
//  Created by Mortgy on 3/20/21.
//

import Foundation
import SENetworking

struct NetworkConfiguration {
    var apiKey: String = "76106449e2d2479fbd182f66ba20f54c"
    var apiBaseURL: URL {
        return try! URL(string: "https://" + Configuration.value(for: "API_BASE_URL"))!
    }
}

class DIContainer {
    static let shared = DIContainer()

    lazy var networkConfiguration = NetworkConfiguration()

    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: networkConfiguration.apiBaseURL,
                                          queryParameters: ["key": networkConfiguration.apiKey])

        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
}
