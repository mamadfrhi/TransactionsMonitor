//
//  InternetChecker.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//


struct InternetChecker {
    
    func isOnline() -> Bool { Connectivity.isConnectedToInternet }
    
}
