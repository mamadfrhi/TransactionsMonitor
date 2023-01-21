//
//  TransactionTableViewDelegate.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

class TransactionTableViewDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        TransactionTableViewFooter(frame: tableView.frame)
    }
    
}
