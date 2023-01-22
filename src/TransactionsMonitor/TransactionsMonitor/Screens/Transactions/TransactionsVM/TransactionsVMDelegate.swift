//
//  TransactionsVMDelegate.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import Foundation

// MARK: Transactions VM Delegate
// implement in VC
// call on VM
protocol TransactionsVMDelegate {
    func updateScreen()
    func hud(show: Bool)
    func showError(errorMessage: String)
}
