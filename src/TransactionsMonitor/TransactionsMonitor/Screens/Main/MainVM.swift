//
//  MainVM.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import Foundation

class MainVM {
    
    // MARK: Dependecies
    private let services = TransactionServices(transactionsAPI:
                                                TransactionsAPI(session:
                                                                    TransactionsAPISessionManager(with: "Token").getTransactionsSession(),
                                                                localJSONLoader: LocalJSONLoader()))
    
    // MARK: Obserbables
    @Published var error: String?
    @Published var transactions: [PBTransaction] = []
    
    
}
