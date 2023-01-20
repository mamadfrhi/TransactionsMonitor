//
//  MainView.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    // MARK: Views
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = 470
        table.layer.backgroundColor = UIColor.white.cgColor
        table.tableFooterView = UIView(frame: .zero)
        return table
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
}

extension MainView: ViewCodeableTemplate {
    func buildViewHierarchy() {
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
}
