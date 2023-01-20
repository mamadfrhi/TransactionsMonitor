//
//  MainVM.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import Foundation

class MainVM {
    
    // MARK: Delegates
    var mainCoordinatorDelegate: MainVMCoordinatorDelegate?
    var viewDelegate: MainVMDelegate?
    
    // MARK: Dependecies
    private let services = TransactionServices(transactionsAPI:
                                                TransactionsAPI(session:
                                                                    TransactionsAPISessionManager(with: "Token").getTransactionsSession(),
                                                                localJSONLoader: LocalJSONLoader()))
    
    // MARK: Obserbables
    @Published var error: String?
    @Published var transactions: [PBTransaction] = []
}


extension MainVM {
    
    func fetchTransactions() {
        
        self.viewDelegate?.hud(show: true)
        
        services.fetchTransactions { transactions, error in
            // failure
            if let error = error {
                let errorMessage = error.localizedDescription
                self.showError(with: errorMessage)
                return
            }
            
            if let transactions = transactions {
                // success
                self.transactions = transactions
                self.viewDelegate?.updateScreen()
                self.viewDelegate?.hud(show: false)
            } else {
                // failure
                self.showError(with: TransactionsAPIError.noData.localizedDescription)
            }
        }
    }
    
    private func showError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.viewDelegate?.showError(errorMessage: errorMessage)
        }
    }
}


