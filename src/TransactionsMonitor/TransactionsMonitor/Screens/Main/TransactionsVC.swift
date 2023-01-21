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
    private let mainTableViewDataSource: MainTableViewDataSource = MainTableViewDataSource()
    private let transactionsView = TransactionsView(frame: screenBounds)
    private let mainVM = MainVM()
    
    // MARK: Properties
    private let hud = ProgressHUD(title: "Please wait...", theme: .dark)
    private var cancelables: Set<AnyCancellable> = []
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        [hud].forEach(view.addSubview(_:)) // add HUD on VC
        configTableView()
        setupBindings()
        mainVM.viewDelegate = self
        fetchTransactions()
    }
    
    override func loadView() {
        self.view = transactionsView
    }
    
    // MARK: Functions
    private func fetchTransactions() {
        mainVM.fetchTransactions()
    }
    
    @objc func retryButtonPressed(_ sender: UIButton) {
        fetchTransactions()
    }
}

// MARK: - SETUPS
extension TransactionsVC {
    private func configTableView() {
        transactionsView.tableView.dataSource = mainTableViewDataSource
    }
    
    private func setupBindings() {
        mainVM.$transactions
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] transactions in
                self?.mainTableViewDataSource.transactions = transactions
            }
            .store(in: &cancelables)
        
        mainVM.$errorMessage
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
extension TransactionsVC: MainVMDelegate {
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
