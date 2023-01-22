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
    
    func fetchTransactions() async -> Result<[PBTransaction], Error> {
        
        let result = await transactionsAPI.fetch()
        
        switch result {
            
        case .success(let success):
            
            let decoder = JSONDecoder()
            let fetchedTransactions = success
            if let transactionItemsData = try? JSONSerialization.data(withJSONObject: fetchedTransactions),
               let transactions = try? decoder.decode(Array<PBTransaction>.self, from: transactionItemsData) {
                return .success(transactions)
            }
            let error = NSError(domain: "Error happened during conversion!", code: 05)
            return .failure(error)
            
        case .failure(let error):
            return .failure(error)
            
        }
    }
    
}
