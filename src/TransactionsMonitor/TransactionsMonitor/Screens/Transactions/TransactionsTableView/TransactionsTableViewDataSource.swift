//
//  MainTableViewDataSource.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit

class TransactionsTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var cellID = "cell"
    private var _transactions: [PBTransaction]?
    
    var transactions: [PBTransaction]? {
        get {
            _transactions
        }
        set {
            _transactions = newValue
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                    for: indexPath) as? TransactionTableViewCell,
           let transaction = _transactions?[indexPath.row] {
            
            cell.companyNameLabel.text = transaction.companyName
            cell.transactionDescriptionLabel.text = transaction.description
            cell.bookingDateLabel.text = transaction.getBookingDateString()
            
            cell.amountLabel.text = "\(transaction.amount)"
            cell.currencyLabel.text = transaction.currency
            
            return cell
        }
        return UITableViewCell()
    }
    
    func getTransaction(at indexPath: IndexPath) -> PBTransaction? {
        transactions?[indexPath.row]
    }
}

