//
//  MainVM.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import Foundation

class TransactionsVM {
    
    // MARK: Dependecies
    
    private let services: TransactionServices
    private let transactionsSorter: TransactionsArraySorter
    private var transactions: [PBTransaction] = []
    private var filteredTransactions: [PBTransaction] = []
    private var filterIsActive = false
    
    // MARK: Publisheds
    
    enum State {
        case isLoading(Bool)
        case failed(Error)
        case loaded([PBTransaction])
    }
    
    @Published private(set) var state: State
    @Published var summation: Int = 0
    
    
    // MARK: Init
    init(services: TransactionServices,
         transactionsSorter: TransactionsArraySorter,
         transactions: [PBTransaction] = []) {
        self.services = services
        self.transactionsSorter = transactionsSorter
        self.transactions = transactions
        self.state = .loaded(transactions)
    }
}

// MARK: Network
extension TransactionsVM {
    
    func fetchTransactions() async {
        
        self.state = .isLoading(true)
        
        do {
            let transactions = try await services.fetchTransactions()
            self.transactions = transactions
            self.state = .loaded(transactions)
        } catch {
            self.state = .failed(error)
        }
        
        self.state = .isLoading(false)
        setSummationVarialbe()
    }
}

// MARK: Filtering
extension TransactionsVM {
    
    func getUniqueCategories() -> [String] {
        
        let categories = transactions.map { "\($0.category)" }
        let uniqueCategories = Set(categories).sorted()
        return Array(uniqueCategories)
        
    }
    
    func filterTransactions(by category: String) {
        
        if category == Constants.clearFilterKey { //TODO: It must convert to an enum
            state = .loaded(transactions)
            filterIsActive = false
        } else {
            let filtered = transactionsSorter.filter(transactions: transactions,
                                                     by: category)
            filteredTransactions = filtered
            filterIsActive = true
            state = .loaded(filteredTransactions)
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
