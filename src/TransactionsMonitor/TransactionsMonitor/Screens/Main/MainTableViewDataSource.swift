//
//  MainTableViewDataSource.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit

class MainTableViewDataSource: NSObject, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if let companyName = _transactions?[indexPath.row].companyName {
            cell.textLabel?.text = companyName
        }
        return cell
    }
}

