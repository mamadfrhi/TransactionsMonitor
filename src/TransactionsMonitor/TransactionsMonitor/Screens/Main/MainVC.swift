//
//  MainVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit
import Combine

class MainVC: UIViewController {
    
    // MARK: Dependencies
    private let mainTableViewDataSource: MainTableViewDataSource = MainTableViewDataSource()
    private let mainView = MainView(frame: screenBounds)
    private let mainVM = MainVM()
    
    // MARK: Properties
    private var cancelables: Set<AnyCancellable> = []
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setupBindings()
        mainVM.viewDelegate = self
        mainVM.fetchTransactions()
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
    
    private func setupBindings() {
        mainVM.$transactions.sink {
            [weak self] transactions in
            self?.mainTableViewDataSource.transactions = transactions
        }
        .store(in: &cancelables)
    }
}

