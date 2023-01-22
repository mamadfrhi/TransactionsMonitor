//
//  TransactionVMFilteringTests.swift
//  TransactionsMonitorTests
//
//  Created by Mohammad Farrahi on 22.01.23.
//

import XCTest
@testable import TransactionsMonitor

final class TransactionsVMFilteringTests: XCTestCase {
    
    private let trasnactionVM = TransactionsVM()
    
}

extension TransactionsVMFilteringTests {
    
    func testSummationFunc() {
        let mockData = TransactionsMockData()
        trasnactionVM.transactions = mockData.transactions
        
        let target = mockData.sumValue
        
        trasnactionVM.setSummationVarialbe()
        let sumValueOnVM = trasnactionVM.summation
        XCTAssertEqual(sumValueOnVM, target)
        
    }
    
    func testSummationOnFilteredCategory1() {
        let mockData = TransactionsMockData()
        let filterBy = "1"
        
        trasnactionVM.transactions = mockData.transactions
        mockData.filterBy(category: filterBy)
        
        let target = mockData.sumValue
        
        trasnactionVM.filterTransactions(by: filterBy)
        let sumValueOnVM = trasnactionVM.summation
        XCTAssertEqual(sumValueOnVM, target)
    }
    
    func testSummationOnFilteredCategory2() {
        let mockData = TransactionsMockData()
        let filterBy = "2"
        
        trasnactionVM.transactions = mockData.transactions
        mockData.filterBy(category: filterBy)
        
        let target = mockData.sumValue
        
        trasnactionVM.filterTransactions(by: filterBy)
        let sumValueOnVM = trasnactionVM.summation
        XCTAssertEqual(sumValueOnVM, target)
    }
    
    func testSummationOnFilteredCategory3() {
        let mockData = TransactionsMockData()
        let filterBy = "3"
        
        trasnactionVM.transactions = mockData.transactions
        mockData.filterBy(category: filterBy)
        
        let target = mockData.sumValue
        
        trasnactionVM.filterTransactions(by: filterBy)
        let sumValueOnVM = trasnactionVM.summation
        XCTAssertEqual(sumValueOnVM, target)
    }
    
    func testSummationOnNoFilter() {
        let mockData = TransactionsMockData()
        let filterBy = Constants.clearFilterKey
        
        trasnactionVM.transactions = mockData.transactions
        mockData.filterBy(category: filterBy)
        
        let target = mockData.sumValue
        
        trasnactionVM.filterTransactions(by: filterBy)
        let sumValueOnVM = trasnactionVM.summation
        XCTAssertEqual(sumValueOnVM, target)
    }
    
    // test fetch func
    func testFetchFunc() async {

        await trasnactionVM.fetchTransactions()
        
        let target = trasnactionVM.transactions.count
        
        XCTAssertGreaterThan(target, 1)
        XCTAssertNil(trasnactionVM.errorMessage)
    }
    
}
