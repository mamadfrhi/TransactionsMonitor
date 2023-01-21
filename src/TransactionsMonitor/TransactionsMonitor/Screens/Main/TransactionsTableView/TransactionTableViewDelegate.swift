//
//  TransactionTableViewDelegate.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

class TransactionTableViewDelegate: NSObject {
    
    let transactionTableViewFooter: TransactionTableViewFooter
    @Published var selectedRow: Int?
    
    internal init(transactionTableViewFooter: TransactionTableViewFooter) {
        self.transactionTableViewFooter = transactionTableViewFooter
    }
}

extension TransactionTableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        transactionTableViewFooter
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
}
