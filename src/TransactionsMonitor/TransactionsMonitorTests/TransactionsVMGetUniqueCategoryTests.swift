//
//  TransactionsVMGetUniqueCategoryTests.swift
//  TransactionsMonitorTests
//
//  Created by Mohammad Farrahi on 22.01.23.
//

import XCTest
@testable import TransactionsMonitor

final class TransactionsVMGetUniqueCategoryTests: XCTestCase {

    private var transactionsMockData: TransactionsMockData!
    private var transactionVM: TransactionsVM!
    
    override func setUp() {
        transactionsMockData = TransactionsMockData()
        transactionVM = makeVM(with: transactionsMockData.transactions)
    }

}

extension TransactionsVMGetUniqueCategoryTests {
    
    func testGetNormalCategories() {
        
        let target = ["1", "2", "3"]
        let categories = transactionVM.getUniqueCategories()
        
        XCTAssertEqual(target, categories)
    }
    
    func testGetCategoriesWithNewCategory() {
        
        let newCategory = 999999999999999
        
        let newTransaction = makeDummyTransaction(category: newCategory)
        transactionsMockData.transactions.append(newTransaction)
        
        transactionVM = makeVM(with: transactionsMockData.transactions)
        
        let target = ["1", "2", "3", "\(newCategory)"]
        let categories = transactionVM.getUniqueCategories()
        
        XCTAssertEqual(target, categories)
    }
    
    func testGetCategoriesWithRemovedCategory() {
        
        transactionsMockData.transactions.removeAll { $0.category == 3 }
        
        transactionVM = makeVM(with: transactionsMockData.transactions)
        
        let target = ["1", "2"]
        let categories = transactionVM.getUniqueCategories()
        
        XCTAssertEqual(target, categories)
    }
    
    func testGetCategoriesSorting() {
        
        let target = ["1", "3", "2"]
        let categories = transactionVM.getUniqueCategories()
        
        XCTAssertNotEqual(target, categories)
    }
    
}
