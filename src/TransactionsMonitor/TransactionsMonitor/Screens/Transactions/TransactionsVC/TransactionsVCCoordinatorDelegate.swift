//
//  TransactionsVMCoordinatorDelegate.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

// MARK: Transactions VC Coordinator Delegate
// implement in TransactionsCoordinator
// call in VC
protocol TransactionsVCCoordinatorDelegate {
    func didSelect(transaction: PBTransaction, from controller: UIViewController)
}
