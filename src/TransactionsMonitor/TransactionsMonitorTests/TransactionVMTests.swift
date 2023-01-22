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

// MARK: To String Date Converter Tests

extension TransactionVMTests {
    
    func testSummation() async {

        let mockkData = TransactionsMockData()
        let targetValue = mockkData.sumValue
        
        trasnactionVM.transactions = mockkData.transactions
        trasnactionVM.setSummationVarialbe()
        
        XCTAssertEqual(targetValue, trasnactionVM.summation)
        
    }
    
}


