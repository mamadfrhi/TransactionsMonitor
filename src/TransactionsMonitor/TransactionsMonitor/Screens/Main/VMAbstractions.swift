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
protocol MainVMType {
    
    var viewDelegate: MainVMDelegate? { get set }
    
    // Events
    
    func didSelectRow(_ row: Int, from controller: UIViewController)
    
    func refreshView()
}

// MARK: - MainVMDelegate(delegate)
// implement in MainCoordinator
// call in VM
protocol MainVMCoordinatorDelegate {
    func didSelect(transaction: PBTransaction, from controller: UIViewController)
}

// MARK: - MainVMDelegate
// implement in VC
// call on VM
protocol MainVMDelegate {
    func updateScreen()
    func hud(show: Bool)
    func showError(errorMessage: String)
    func selectedTransationRow() -> Int
}
