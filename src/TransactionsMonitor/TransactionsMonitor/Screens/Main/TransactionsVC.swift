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
    private let transactionsTableViewDelegate: TransactionTableViewDelegate = TransactionTableViewDelegate(transactionTableViewFooter: TransactionTableViewFooter(frame: .zero))
    private let transactionsView = TransactionsView(frame: screenBounds)
    private let transactionsVM = TransactionsVM()
    private let filterPopoverVC = FilterPopoverVC.`init`(list: [])
    
    // MARK: Properties
    private let hud = ProgressHUD(title: "Please wait...", theme: .dark)
    private var cancelables: Set<AnyCancellable> = []
    private var filterBarButtonItem: UIBarButtonItem!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        [hud].forEach(view.addSubview(_:)) // add HUD on VC
        configTableView()
        setupBindings()
        transactionsVM.viewDelegate = self
        fetchTransactions()
        setupFilterBarButtonItem()
    }
    
    override func loadView() {
        self.view = transactionsView
        self.title = "Transactions"
    }
    
    // MARK: Functions
    private func fetchTransactions() {
        transactionsVM.fetchTransactions()
    }
    
    @objc func retryButtonPressed(_ sender: UIButton) {
        fetchTransactions()
    }
    
    @objc func filterBarButtonPressed(_ sender: Any) {
        let categories = transactionsVM.getUniqueCategories()
        filterPopoverVC.list = categories
        self.present(filterPopoverVC, animated: true)
    }
}

// MARK: - SETUPS
extension TransactionsVC {
    private func configTableView() {
        transactionsView.tableView.dataSource = transactionsTableViewDataSource
        transactionsView.tableView.delegate = transactionsTableViewDelegate
    }
    
    private func setupFilterBarButtonItem() {
        filterBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
                                              style: .done,
                                              target: self,
                                              action: #selector(filterBarButtonPressed(_:)))
        self.navigationItem.setRightBarButton(filterBarButtonItem, animated: true)
    }
    
    private func setupBindings() {
        transactionsVM.$transactions
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] transactions in
                self?.transactionsTableViewDataSource.transactions = transactions
                self?.updateScreen()
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
        
        filterPopoverVC.$chosenCategory
            .sink {
                [weak self] category in
                self?.transactionsVM.filterTransactions(by: category ?? "Clear Filter")
            }
        .store(in: &cancelables)
        
        transactionsVM.$filteredTransactions
            .sink {
                [weak self] filteredTransactions in
                self?.transactionsTableViewDataSource.transactions = filteredTransactions
                self?.updateScreen()
            }
            .store(in: &cancelables)
    }
}

// MARK: TransactionsVMDelegate
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
