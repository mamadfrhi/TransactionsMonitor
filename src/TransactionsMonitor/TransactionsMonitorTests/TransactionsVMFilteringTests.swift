//
//  TransactionVMFilteringTests.swift
//  TransactionsMonitorTests
//
//  Created by Mohammad Farrahi on 22.01.23.
//

import XCTest
@testable import TransactionsMonitor



final class TransactionsVMFilteringTests: XCTestCase {
    
    private var transactionsMockData: TransactionsMockData!
    private var transactionVM: TransactionsVM!
    
    override func setUp() {
        transactionsMockData = TransactionsMockData()
        transactionVM = makeVM(with: transactionsMockData.transactions)
    }
    
}

extension TransactionsVMFilteringTests {
    
    func testSummationFunc() {
        
        let target = transactionsMockData.sumValue
        
        transactionVM.setSummationVarialbe()
        let sumValueOnVM = transactionVM.summation
        
        XCTAssertEqual(sumValueOnVM, target)
        
    }
    
    func testSummationOnFilteredCategory1() {
        
        let filterBy = "1"
        transactionsMockData.filterBy(category: filterBy)
        
        let target = transactionsMockData.sumValue
        
        transactionVM.filterTransactions(by: filterBy)
        let sumValueOnVM = transactionVM.summation
        
        XCTAssertEqual(sumValueOnVM, target)
    }
    
    func testSummationOnFilteredCategory2() {
        
        let filterBy = "2"
        transactionsMockData.filterBy(category: filterBy)
        
        let target = transactionsMockData.sumValue
        
        transactionVM.filterTransactions(by: filterBy)
        let sumValueOnVM = transactionVM.summation
        
        XCTAssertEqual(sumValueOnVM, target)
    }
    
    func testSummationOnFilteredCategory3() {
        
        let filterBy = "3"
        transactionsMockData.filterBy(category: filterBy)
        
        let target = transactionsMockData.sumValue
        
        transactionVM.filterTransactions(by: filterBy)
        let sumValueOnVM = transactionVM.summation
        
        XCTAssertEqual(sumValueOnVM, target)
    }
    
    func testSummationOnNoFilter() {
        
        let filterBy = Constants.clearFilterKey
        transactionsMockData.filterBy(category: filterBy)
        
        let target = transactionsMockData.sumValue
        
        transactionVM.filterTransactions(by: filterBy)
        let sumValueOnVM = transactionVM.summation
        
        XCTAssertEqual(sumValueOnVM, target)
    }
    
    // test fetch func
    func testFetchFunc() async {
        
        await transactionVM.fetchTransactions()
        
        let target = transactionVM.summation
        let state = transactionVM.state
        
        switch state {
        case .isLoading(let value):
            value ? XCTAssertNotEqual(target, 0) : XCTAssertNotEqual(target, 0)
            return
        case .failed(_):
            XCTAssertEqual(target, 0)
        case .loaded(_):
            XCTAssertNotEqual(target, 0)
        }
    }
    
}
