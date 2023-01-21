//
//  ArraySorter.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

protocol ArraySorter {
    
    associatedtype T
    
    func sortByDate(transactions: [T]) -> [T]
    
    func filter(transactions: [T], by: String) -> [T]
}
