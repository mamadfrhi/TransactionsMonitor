//
//  TransactionVMTests.swift
//  TransactionsMonitorTests
//
//  Created by Mohammad Farrahi on 22.01.23.
//

import XCTest
@testable import TransactionsMonitor

final class TransactionVMTests: XCTestCase {
    
    private let trasnactionVM = TransactionsVM()
    
}

extension TransactionVMTests {
    
    func testSummation() async {

        let mockkData = TransactionsMockData()
        let targetValue = mockkData.sumValue
        
        trasnactionVM.transactions = mockkData.transactions
        trasnactionVM.setSummationVarialbe()
        
        XCTAssertEqual(targetValue, trasnactionVM.summation)
        
    }
    
    func testNoFilter() {
        let mockkData = TransactionsMockData()
        
        mockkData.filterBy(category: -1)
        let targetValue = mockkData.transactions.count
        
        trasnactionVM.filterTransactions(by: Constants.clearFilterKey)
        let filteredCountOnVM = trasnactionVM.filteredTransactions.count
        
        XCTAssertEqual(filteredCountOnVM, targetValue)
        
    }
    
}


