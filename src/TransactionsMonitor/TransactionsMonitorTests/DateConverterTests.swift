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
    
}

// MARK: To String Date Converter Tests

extension DateConverterTests {
    
    func testRecentStringDateOnDateConverter() {
        
        let isoTimeStamp = "2022-07-22T10:59:05+0200"    // input
        let dateStringFromisoTimeStamp = "2022-07-22"    // output
        
        let convertedDate = dateConverter.readableStringDate(from: isoTimeStamp)
        
        XCTAssertEqual(convertedDate, dateStringFromisoTimeStamp)
        
    }
    
    func testOldStringDateOnDateConverter() {
        
        let isoTimeStamp = "1980-01-01T10:59:05+0000"    // input
        let dateStringFromisoTimeStamp = "1980-01-01"    // output
        
        let convertedDate = dateConverter.readableStringDate(from: isoTimeStamp)
        
        XCTAssertEqual(convertedDate, dateStringFromisoTimeStamp)
        
    }
}

// MARK: To Date Converter Tests

extension DateConverterTests {
    
    func testRecentDateOnDateConverter() {
        
        let inputStringDate = "2022-07-22T10:59:05+0000"
        let dateObject = ISO8601DateFormatter().date(from: inputStringDate)
        
        XCTAssertNotNil(dateObject)
        
        let convertedDate = dateConverter.isoDate(isoString: inputStringDate)
        
        XCTAssertEqual(convertedDate, convertedDate)
    }
    
    func testOldDateOnDateConverter() {
        
        let inputStringDate = "1800-07-22T10:59:00+0000"
        let dateObject = ISO8601DateFormatter().date(from: inputStringDate)
        
        XCTAssertNotNil(dateObject)
        
        let convertedDate = dateConverter.isoDate(isoString: inputStringDate)
        
        XCTAssertEqual(convertedDate, convertedDate)
    }
    
}
