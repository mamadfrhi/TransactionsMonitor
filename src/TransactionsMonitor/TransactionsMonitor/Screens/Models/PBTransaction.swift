//
//  PBTransaction.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 19.01.23.
//

struct PBTransaction: Codable {
    let companyName: String
    let alias: PBTransactionAlias
    let category: Int
    let transactionDetail: PBTransactionDetail
    
    enum CodingKeys: String, CodingKey {
        case companyName = "partnerDisplayName",
        alias, category, transactionDetail
    }
}

struct PBTransactionAlias: Codable {
    let reference: String
}
