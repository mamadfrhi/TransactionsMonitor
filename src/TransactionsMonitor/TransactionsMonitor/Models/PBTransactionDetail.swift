//
//  PBTransactionDetail.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 19.01.23.
//

import Foundation

struct PBTransactionDetail: Codable {
    let description: String?
    let bookingDate: String
    let value: PBTransactionValue
}

struct PBTransactionValue: Codable {
    let amount   : Int
    let currency : String
}
