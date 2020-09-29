//
//  EnvironmentHandler.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Foundation

class EnvironmentHandler {
    static let shared = EnvironmentHandler()
    private init() {
    }
    var mockAPI: Bool {
        guard let result = ProcessInfo.processInfo.environment["Mock-API"] else {return false}
        return result == "true"
    }
}
