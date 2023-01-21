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
    private let transactionsSorter = TransactionsArraySorter()
    
    // MARK: Obserbables
    @Published var errorMessage: String?
    @Published var transactions: [PBTransaction] = []
    @Published var filteredTransactions: [PBTransaction] = []
}

// MARK: Network
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
                let sorted = self.transactionsSorter.sortByDate(transactions: transactions)
                self.transactions = sorted
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

// MARK: Filtering
extension TransactionsVM {
    
    private func resetFilter() { self.filteredTransactions = transactions }
    
    func getUniqueCategories() -> [String] {
        resetFilter()
        let categories = transactions.map { "\($0.category)" }
        let uniqueCategories = Set(categories)
        return Array(uniqueCategories)
    }
    
    func filterTransactions(by category: String) {
        if category == "Clear Filter" { //TODO: It must convert to an enum
            transactions = transactions
            return
        }
        
        let filtered = transactionsSorter.filter(transactions: transactions,
                                                 by: category)
        filteredTransactions = filtered
    }
}
