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
        let isoTimeStamp = "2022-04-10T16:16:36.940Z"    // input
        let dateStringFromisoTimeStamp = "2022-04-10"    // output
        
        let convertedDate = dateConverter.readableDate(from: isoTimeStamp)
        
        XCTAssertEqual(convertedDate, dateStringFromisoTimeStamp)
        
    }

}
