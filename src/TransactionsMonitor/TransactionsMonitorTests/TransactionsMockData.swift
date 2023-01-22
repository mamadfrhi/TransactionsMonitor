//
//  TransactionsMockData.swift
//  TransactionsMonitorTests
//
//  Created by Mohammad Farrahi on 22.01.23.
//

import XCTest
@testable import TransactionsMonitor

class TransactionsMockData {
    
    init(fromJson fileName: String = "PBTransactions" ) {
        let decoder = JSONDecoder()
        let jsonTransactions = LocalJSONLoader().loadJson(filename: fileName)
        let transactionItemsData = try! JSONSerialization.data(withJSONObject: jsonTransactions!)
        let transactions = try! decoder.decode(Array<PBTransaction>.self, from: transactionItemsData)
        self.transactions = transactions
    }
    
    var transactions: [PBTransaction]
    
    var sumValue: Int {
        transactions.map{ $0.amount }
            .reduce(0, +)
    }
    
    func filterBy(category: String) {
        if category == Constants.clearFilterKey { //TODO: It must convert to an enum
            return
        }
        transactions = transactions.filter { $0.category == Int(category) }
    }
    
    
    let pbTransactionJSON = """
    {
          "partnerDisplayName" : "REWE Group",
          "alias" : {
            "reference" : "795357452000810"
          },
          "category" : 1,
          "transactionDetail" : {
            "description" : "Punkte sammeln",
            "bookingDate" : "2022-07-24T10:59:05+0200",
            "value" : {
              "amount" : 124,
              "currency" : "PBP"
            }
          }
        },
        {
          "partnerDisplayName" : "dm-dogerie markt",
          "alias" : {
            "reference" : "098193809705561"
          },
          "category" : 1,
          "transactionDetail" : {
            "description" : "Punkte sammeln",
            "bookingDate" : "2022-06-23T10:59:05+0200",
            "value" : {
              "amount" : 1240,
              "currency" : "PBP"
            }
          }
        },
        {
          "partnerDisplayName" : "OTTO Group",
          "alias" : {
            "reference" : "094844835601044"
          },
          "category" : 2,
          "transactionDetail" : {
            "bookingDate" : "2022-07-22T10:59:05+0200",
            "value" : {
              "amount" : 53,
              "currency" : "PBP"
            }
          }
        },
        {
          "partnerDisplayName" : "REWE Group",
          "alias" : {
            "reference" : "075903074248681"
          },
          "category" : 3,
          "transactionDetail" : {
            "description" : "Punkte sammeln",
            "bookingDate" : "2022-11-11T10:59:05+0200",
            "value" : {
              "amount" : 86,
              "currency" : "PBP"
            }
          }
        },
    """
}


