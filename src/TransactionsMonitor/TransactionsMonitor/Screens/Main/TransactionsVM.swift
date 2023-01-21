//
//  MainVM.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import Foundation

class TransactionsVM {
    
    // MARK: Delegates
    var transactionsCoordinatorDelegate: TransactionsVMCoordinatorDelegate?
    var viewDelegate: TransactionsVMDelegate?
    
    // MARK: Dependecies
    private let services = TransactionServices(transactionsAPI:
                                                TransactionsAPI(session:
                                                                    TransactionsAPISessionManager(with: "Token").getTransactionsSession(),
                                                                localJSONLoader: LocalJSONLoader()))
    
    // MARK: Obserbables
    @Published var errorMessage: String?
    @Published var transactions: [PBTransaction] = []
}


extension TransactionsVM {
    
    func fetchTransactions() {
        
        self.viewDelegate?.hud(show: true)
        
        services.fetchTransactions { transactions, error in
            // failure
            if let error = error {
                let errorMessage = error.localizedDescription
                self.showError(with: errorMessage)
                self.viewDelegate?.hud(show: false)
                return
            }
            
            if let transactions = transactions {
                // success
                self.transactions = transactions
                self.viewDelegate?.updateScreen()
            } else {
                // failure
                self.showError(with: TransactionsAPIError.noData.localizedDescription)
            }
            self.viewDelegate?.hud(show: false)
        }
    }
    
    private func showError(with errorMessage: String) {
        self.errorMessage = errorMessage
    }
}


