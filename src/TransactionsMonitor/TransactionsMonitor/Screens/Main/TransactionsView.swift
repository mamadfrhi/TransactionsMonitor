//
//  MainView.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit
import SnapKit

class TransactionsView: UIView {
    
    // MARK: Views
    let tableView: UITableView = {
        let table = UITableView()
        table.register(TransactionTableViewCell.self, forCellReuseIdentifier: "cell")
        table.layer.backgroundColor = UIColor.white.cgColor
        return table
    }()
    
    let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry!", for: .normal)
        button.addTarget(nil,
                         action: #selector(TransactionsVC().retryButtonPressed(_:)),
                         for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.setupView() // call template
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Function
    func hideRetryButton(_ value: Bool) {
        retryButton.isHidden = value
    }
}

// MARK: Custom View Template
extension TransactionsView: ViewCodeableTemplate {
    func buildViewHierarchy() {
        self.addSubview(tableView)
        self.addSubview(retryButton)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        retryButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
