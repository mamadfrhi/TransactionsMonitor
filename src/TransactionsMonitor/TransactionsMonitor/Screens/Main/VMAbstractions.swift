//
//  Types.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import Foundation

import UIKit

// MARK: - ViewModelType
// implement in VM
protocol TransactionsVMType {
    
    var viewDelegate: TransactionsVMDelegate? { get set }
    
    // Events
    
    func didSelectRow(_ row: Int, from controller: UIViewController)
    
    func refreshView()
}

// MARK: - Transactions VM Coordinator Delegate
// implement in TransactionsCoordinator
// call in VM
protocol TransactionsVMCoordinatorDelegate {
    func didSelect(transaction: PBTransaction, from controller: UIViewController)
}

// MARK: - Transactions VM Delegate
// implement in VC
// call on VM
protocol TransactionsVMDelegate {
    func updateScreen()
    func hud(show: Bool)
    func showError(errorMessage: String)
    func selectedTransationRow() -> Int
}
