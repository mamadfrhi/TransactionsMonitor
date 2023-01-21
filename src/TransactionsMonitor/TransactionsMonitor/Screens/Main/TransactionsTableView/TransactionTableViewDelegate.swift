//
//  TransactionTableViewDelegate.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

class TransactionTableViewDelegate: NSObject {
    
    let transactionTableViewFooter: TransactionTableViewFooter
    
    internal init(transactionTableViewFooter: TransactionTableViewFooter) {
        self.transactionTableViewFooter = transactionTableViewFooter
    }
}

extension TransactionTableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        transactionTableViewFooter
    }
    
}
