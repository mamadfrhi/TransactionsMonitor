//
//  TransactionsVMGetUniqueCategoryTests.swift
//  TransactionsMonitorTests
//
//  Created by Mohammad Farrahi on 22.01.23.
//

import XCTest
@testable import TransactionsMonitor

final class TransactionsVMGetUniqueCategoryTests: XCTestCase {

    private let trasnactionVM = TransactionsVM()

}

extension TransactionsVMGetUniqueCategoryTests {
    
    func testGetNormalCategories() {
        let mockData = TransactionsMockData()
        trasnactionVM.transactions = mockData.transactions
        
        let target = ["1", "2", "3"]
        let test = trasnactionVM.getUniqueCategories()
        
        XCTAssertEqual(target, test)
    }
    
    func testGetCategoriesWithNewCategory() {
        
        let mockData = TransactionsMockData()
        let newCategory = 999999999999999
        
        let newTransaction = makeDummyTransaction(category: newCategory)
        mockData.transactions.append(newTransaction)
        
        trasnactionVM.transactions = mockData.transactions
        
        let target = ["1", "2", "3", "\(newCategory)"]
        let test = trasnactionVM.getUniqueCategories()
        
        XCTAssertEqual(target, test)
    }
    
    func testGetCategoriesWithRemovedCategory() {
        
        let mockData = TransactionsMockData()
        
        mockData.transactions.removeAll { $0.category == 3 }
        
        trasnactionVM.transactions = mockData.transactions
        
        let target = ["1", "2"]
        let test = trasnactionVM.getUniqueCategories()
        
        XCTAssertEqual(target, test)
    }
    
    func testGetCategoriesSorting() {
        
        let mockData = TransactionsMockData()
        trasnactionVM.transactions = mockData.transactions
        
        let target = ["1", "3", "2"]
        let test = trasnactionVM.getUniqueCategories()
        
        XCTAssertNotEqual(target, test)
    }
    
    
    // MARK: Helper
    
    func makeDummyTransaction(category: Int) -> PBTransaction {
        // append new transaction with a new category
        let transaction = PBTransaction(companyName: "Apple",
                                           reference: "1100",
                                           category: category,
                                           bookingISODate: "2022-02-04T10:59:05+0200",
                                           amount: 0,
                                           currency: "Dollar")
        return transaction
    }
}
