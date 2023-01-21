//
//  TransactionsArraySorter.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import Foundation

struct TransactionsArraySorter: ArraySorter {
    
    func sortByDate(transactions: [PBTransaction]) -> [PBTransaction] {
        transactions.sorted { $0.getBookingDate() > $1.getBookingDate() }
    }
    
    func filter(transactions: [PBTransaction], by: String) -> [PBTransaction] {
        transactions.filter { $0.category == Int(by) }
    }
}
