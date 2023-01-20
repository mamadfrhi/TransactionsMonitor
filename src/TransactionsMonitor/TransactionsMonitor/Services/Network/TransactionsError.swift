//
//  TransactionsError.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 19.01.23.
//

import Foundation

struct TransactionsAPIError: Error {
    static let noData = NSError(domain: "Server response is not valid.", code: 01, userInfo: nil)
    static let clientError = NSError(domain: "A HTTPS client error occured.", code: 02, userInfo: nil)
    static let serverError = NSError(domain: "A HTTPS server error occured.", code: 03, userInfo: nil)
    static let disconnected = NSError(domain: " You're not connected to the internet.", code: 04, userInfo: nil)
}