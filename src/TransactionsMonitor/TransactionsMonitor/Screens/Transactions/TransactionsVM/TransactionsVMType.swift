//
//  TransactionsVMType.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

// MARK: ViewModelType
// implement in VM
protocol TransactionsVMType {
    
    var viewDelegate: TransactionsVMDelegate? { get set }
    
    // Events
    
    func didSelectRow(_ row: Int, from controller: UIViewController)
    
    func refreshView()
}
