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
    func fetchTransactions(completionHandler: @escaping ([PBTransaction]?, Error?) -> ()) {
        transactionsAPI.fetch { result in
            switch result {
            case .success(let success):
                let decoder = JSONDecoder()
                if let fetchedTransactions = success,
                    let transactionItemsData = try? JSONSerialization.data(withJSONObject: fetchedTransactions),
                   let transactions = try? decoder.decode(Array<PBTransaction>.self, from: transactionItemsData) {
                    completionHandler(transactions, nil)
                    return
                }
                completionHandler(nil, TransactionsAPIError.noData)
                return
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
