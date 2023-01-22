//
//  MainVM.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import Foundation

class TransactionsVM {
    
    // MARK: Delegates
    
    var viewDelegate: TransactionsVMDelegate?
    
    // MARK: Dependecies
    
    private let services: TransactionServices
    private let transactionsSorter: TransactionsArraySorter
    var filterIsActive = false
    
    // MARK: Obserbables
    
    @Published var errorMessage: String?
    @Published var transactions: [PBTransaction] = []
    @Published var filteredTransactions: [PBTransaction] = []
    @Published var summation: Int = 0
    
    
    // MARK: Init
    required
    init(services: TransactionServices,
         transactionsSorter: TransactionsArraySorter,
         transactions: [PBTransaction] = []) {
        self.services = services
        self.transactionsSorter = transactionsSorter
        self.transactions = transactions
    }
}

// MARK: Network
extension TransactionsVM {
    
    func fetchTransactions() async {
        
        self.viewDelegate?.hud(show: true)
        let response = await services.fetchTransactions()
        
        switch response {
        case .success(let transactions):
            self.transactions = transactions
        case .failure(let error):
            self.showError(with: error.localizedDescription)
        }
        
        self.viewDelegate?.hud(show: false)
        setSummationVarialbe()
    }
    
    private func showError(with errorMessage: String) {
        self.errorMessage = errorMessage
    }
}

// MARK: Filtering
extension TransactionsVM {
    
    private func resetFilter() {
        self.filteredTransactions = transactions
        filterIsActive = false
    }
    
    func getUniqueCategories() -> [String] {
        resetFilter()
        let categories = transactions.map { "\($0.category)" }
        let uniqueCategories = Set(categories).sorted()
        return Array(uniqueCategories)
    }
    
    func filterTransactions(by category: String) {
        if category == Constants.clearFilterKey { //TODO: It must convert to an enum
            resetFilter()
        } else {
            let filtered = transactionsSorter.filter(transactions: transactions,
                                                     by: category)
            filteredTransactions = filtered
            filterIsActive = true
        }
        setSummationVarialbe()
    }
}

// MARK: Summation
extension TransactionsVM {
    func setSummationVarialbe() {
        var sum = 0
        if filterIsActive {
            sum = filteredTransactions
                .map { $0.amount }
                .reduce(0, +)
        } else {
            sum = transactions
                .map { $0.amount }
                .reduce(0, +)
        }
        summation = sum
    }
}
