//
//  DateFormatter.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import Foundation

struct DateConverter {
    
    func readableDate(from inputDate: String) -> String {
        // iso
        let isoString = inputDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        if let isoDate = formatter.date(from: isoString) {
            // normal
            formatter.dateFormat = "yyyy-MM-dd"
            let stringDate = formatter.string(from: isoDate)
            return stringDate
        }
        return formatter.string(from: Date())
        // if data conversion failed, return today's date
    }
    
}
