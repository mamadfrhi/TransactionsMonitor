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
protocol TransactionsViewModelType {
    
    var viewDelegate: TransactionsViewModelViewDelegate? { get set }
    
    // Events
    
    func didSelectRow(_ row: Int, from controller: UIViewController)
    
    func refreshView()
}

// MARK: - ViewModelCoordinator(delegate)
// implement in MainCoordinator
// call in VM
protocol TransactionsViewModelCoordinatorDelegate {
    func didSelect(transaction: PBTransaction, from controller: UIViewController)
}

// MARK: - ViewModelViewDelegate
// implement in VC
// call on VM
protocol TransactionsViewModelViewDelegate {
    func updateScreen()
    func hud(show: Bool)
    func showError(errorMessage: String)
    func selectedTransationRow() -> Int
}
