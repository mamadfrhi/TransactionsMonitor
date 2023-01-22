//
//  PBTransaction.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 19.01.23.
//

import Foundation

struct PBTransaction: Codable {
    let companyName: String
    let reference: String
    let category: Int
    
    let description: String?
    let bookingISODate: String
    
    let amount   : Int
    let currency : String
    
    // MARK: Keys
    enum TransactionKeys: String, CodingKey {
        case companyName = "partnerDisplayName",
             alias, category, transactionDetail
    }
    
    enum AliasKeys: String, CodingKey {
        case reference
    }
    
    enum TransactionDetailKeys: String, CodingKey {
        case description,
             bookingISODate = "bookingDate",
             value
    }
    
    enum ValueKeys: String, CodingKey {
        case amount, currency
    }
    
    // MARK: Init
    
    init(from decoder: Decoder) throws {
        let transactionContainer = try decoder.container(keyedBy: TransactionKeys.self)
        self.companyName = try transactionContainer.decode(String.self, forKey: .companyName)
        self.category = try transactionContainer.decode(Int.self, forKey: .category)
        
        let aliasContainer = try transactionContainer.nestedContainer(keyedBy: AliasKeys.self, forKey: .alias)
        self.reference = try aliasContainer.decode(String.self, forKey: .reference)
        
        let detailContainer = try transactionContainer.nestedContainer(keyedBy: TransactionDetailKeys.self, forKey: .transactionDetail)
        self.description = try detailContainer.decodeIfPresent(String.self, forKey: .description)
        self.bookingISODate = try detailContainer.decode(String.self, forKey: .bookingISODate)
        
        let valueContainer = try detailContainer.nestedContainer(keyedBy: ValueKeys.self, forKey: .value)
        self.amount = try valueContainer.decode(Int.self, forKey: .amount)
        self.currency = try valueContainer.decode(String.self, forKey: .currency)
    }
    
    init(companyName: String,
         reference: String,
         category: Int,
         description: String? = nil,
         bookingISODate: String,
         amount: Int,
         currency: String) {
        self.companyName = companyName
        self.reference = reference
        self.category = category
        self.description = description
        self.bookingISODate = bookingISODate
        self.amount = amount
        self.currency = currency
    }
}


// MARK: PBTransactionReadable
// it can be done also using Decorator Design Pattern
extension PBTransaction: PBTransactionReadable {
    func getBookingDate() -> Date {
        DateConverter().isoDate(isoString: bookingISODate)
    }
    
    func getBookingDateString() -> String {
        DateConverter().readableStringDate(from: bookingISODate)
    }
}
