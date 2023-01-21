//
//  MainVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit
import Combine

class TransactionsVC: UIViewController {
    
    // MARK: Dependencies
    private let transactionsTableViewDataSource: TransactionsTableViewDataSource = TransactionsTableViewDataSource()
    private let transactionsView = TransactionsView(frame: screenBounds)
    private let transactionsVM = TransactionsVM()
    
    // MARK: Properties
    private let hud = ProgressHUD(title: "Please wait...", theme: .dark)
    private var cancelables: Set<AnyCancellable> = []
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        [hud].forEach(view.addSubview(_:)) // add HUD on VC
        configTableView()
        setupBindings()
        transactionsVM.viewDelegate = self
        fetchTransactions()
    }
    
    override func loadView() {
        self.view = transactionsView
    }
    
    // MARK: Functions
    private func fetchTransactions() {
        transactionsVM.fetchTransactions()
    }
    
    @objc func retryButtonPressed(_ sender: UIButton) {
        fetchTransactions()
    }
}

// MARK: - SETUPS
extension TransactionsVC {
    private func configTableView() {
        transactionsView.tableView.dataSource = transactionsTableViewDataSource
    }
    
    private func setupBindings() {
        transactionsVM.$transactions
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] transactions in
                self?.transactionsTableViewDataSource.transactions = transactions
            }
            .store(in: &cancelables)
        
        transactionsVM.$errorMessage
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] errorMessage in
                let errorText = errorMessage ?? "Something wrong happened"
                self?.showError(errorMessage: errorText)
            }
            .store(in: &cancelables)
    }
}

// MARK: MainVMDelegate
extension TransactionsVC: TransactionsVMDelegate {
    func updateScreen() {
        DispatchQueue.main.async {
            self.transactionsView.tableView.reloadData()
            self.transactionsView.hideRetryButton(true)
        }
    }
    
    func hud(show: Bool) {
        DispatchQueue.main.async {
            show ? self.hud.show() : self.hud.hide()
        }
    }
    
    func showError(errorMessage: String) {
        self.showAlert(alertTitle: "Error!", alertMessage: errorMessage)
        self.transactionsView.hideRetryButton(false)
    }
    
    func selectedTransationRow() -> Int {
        print("Selected row is: ", transactionsView.tableView.indexPathForSelectedRow?.row as Any)
        return 0
    }
    
    
}
