//
//  MainVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit

class MainVC: UIViewController {
    // MARK: Dependencies
    private let mainTableViewDataSource: MainTableViewDataSource = MainTableViewDataSource()
    private let mainView = MainView(frame: screenBounds)
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    override func loadView() {
        self.view = mainView
    }
}

// MARK: - SETUPS
extension MainVC {
    private func configTableView() {
        mainView.tableView.dataSource = mainTableViewDataSource
    }
}

