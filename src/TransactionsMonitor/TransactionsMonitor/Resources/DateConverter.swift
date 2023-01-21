//
//  DateFormatter.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import Foundation

struct DateConverter {
    
    func readablestringDate(from ISO8601Date: String) -> String {
        // iso
        let isoString = ISO8601Date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let isoDate = formatter.date(from: isoString) {
            // normal
            formatter.dateFormat = "yyyy-MM-dd"
            let stringDate = formatter.string(from: isoDate)
            return stringDate
        }
        return formatter.string(from: Date())
        // if data conversion failed, return today's date
    }
    
    func readableDate(from ISO8601Date: String) -> Date {
        ISO8601DateFormatter().date(from: ISO8601Date) ?? Date()
        // if date conversion failed, return today's date
    }
    
}
