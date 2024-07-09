//
//  TransactionsError.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 19.01.23.
//

import SwiftUI

enum TransactionsAPIErrors: LocalizedError {
    
    case noData ,clientError ,serverError ,disconnected
    
    var errorDescription: String {
        switch self {
            
        case .noData:
            return String(localized: "error.no.data")
        case .clientError:
            return String(localized: "error.client")
        case .serverError:
            return String(localized: "error.server")
        case .disconnected:
            return String(localized: "error.internet.disconnect")
        }
    }
    
    
}
