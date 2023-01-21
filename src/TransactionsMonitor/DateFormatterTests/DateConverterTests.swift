//
//  DateFormatterTests.swift
//  DateFormatterTests
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import XCTest
@testable import TransactionsMonitor

final class DateConverterTests: XCTestCase {

    private let dateConverter = DateConverter()
    
    func testDateConverter() {
        
        // Test time convertor (in catView wrapper)
        let isoTimeStamp = "2022-07-22T10:59:05+0200"    // input
        let dateStringFromisoTimeStamp = "2022-07-22"    // output
        
        let convertedDate = dateConverter.readablestringDate(from: isoTimeStamp)
        
        XCTAssertEqual(convertedDate, dateStringFromisoTimeStamp)
        
    }

}
