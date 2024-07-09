//
//  TransactionVMTestHelpers.swift
//  TransactionsMonitorTests
//
//  Created by Mohammad Farrahi on 23.01.23.
//

import Foundation
@testable import TransactionsMonitor

func makeVM(with transactions: [PBTransaction]) -> TransactionsVM {
    let jsonLoader = LocalJSONLoader()
    let transactionSorter = TransactionsArraySorter()
    
    let session = TransactionsAPISessionManager(with: "Token").getTransactionsSession()
    let transactionAPI = TransactionsAPI(session: session,
                                         localJSONLoader: jsonLoader,
                                         internetChecker: InternetChecker())
    let transactionServices = TransactionServices(transactionsAPI: transactionAPI)
    let transactionsVM = TransactionsVM(services: transactionServices,
                                        transactionsSorter: transactionSorter,
                                        transactions: transactions)
    return transactionsVM
}

func makeDummyTransaction(category: Int) -> PBTransaction {
    // append new transaction with a new category
    let transaction = PBTransaction(companyName: "Apple",
                                       reference: "1100",
                                       category: category,
                                       bookingISODate: "2022-02-04T10:59:05+0200",
                                       amount: 0,
                                       currency: "Dollar")
    return transaction
}
