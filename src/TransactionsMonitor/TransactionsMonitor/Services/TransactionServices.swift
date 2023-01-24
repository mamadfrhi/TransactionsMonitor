//
//  TransactionServices.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import Foundation

class TransactionServices {
    
    private let transactionsAPI: TransactionsAPI
    
    internal init(transactionsAPI: TransactionsAPI) {
        self.transactionsAPI = transactionsAPI
    }
}

// MARK: API Calls
extension TransactionServices {
    
    func fetchTransactions() async throws -> [PBTransaction] {
        
        do {
            let fetchedTransactions = try await transactionsAPI.fetch()
            let decoder = JSONDecoder()
            
            if let transactionItemsData = try? JSONSerialization.data(withJSONObject: fetchedTransactions),
               let transactions = try? decoder.decode(Array<PBTransaction>.self, from: transactionItemsData) {
                return transactions
            }
            let error = NSError(domain: "Error happened during conversion!", code: 05)
            throw error
            
        } catch let error {
            throw error
        }
        
    }
    
}
