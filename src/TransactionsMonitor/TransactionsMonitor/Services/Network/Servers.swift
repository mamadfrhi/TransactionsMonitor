//
//  Servers.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 18.01.23.
//

import Foundation

enum Servers : String {
    case test        = "dev"
    case production  = "prod"
    
    var rootURL: URL {
        switch self {
        case .test:
            return URL(string: "https://api.payback.com/")!
        case .production:
            return URL(string: "https://api-test.payback.com/")!
        }
    }
}
