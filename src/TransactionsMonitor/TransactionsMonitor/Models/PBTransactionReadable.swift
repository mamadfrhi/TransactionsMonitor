//
//  PBTransactionReadable.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import Foundation

protocol PBTransactionReadable {
    func getBookingDate() -> Date?
    func getBookingDateString() -> String
}
