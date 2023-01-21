//
//  TransactionsVMCoordinatorDelegate.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

// MARK: Transactions VM Coordinator Delegate
// implement in TransactionsCoordinator
// call in VM
protocol TransactionsVMCoordinatorDelegate {
    func didSelect(transaction: PBTransaction, from controller: UIViewController)
}
