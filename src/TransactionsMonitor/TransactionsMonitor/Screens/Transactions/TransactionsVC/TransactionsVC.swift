//
//  MainVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit
import Combine

final
class TransactionsVC: UIViewController {
    
    // MARK: Dependencies
    
    private let transactionsTableViewDataSource: TransactionsTableViewDataSource
    private let transactionsTableViewDelegate: TransactionTableViewDelegate
    private let transactionsView: TransactionsView
    private let transactionsVM : TransactionsVM
    private let filterPopoverVC: FilterPopoverVC
    
    // MARK: Delegate
    var transactionsCoordinatorDelegate: TransactionsVCCoordinatorDelegate?
    
    // MARK: Properties
    private let hud = ProgressHUD(title: "Please wait...", theme: .dark)
    private var cancelables: Set<AnyCancellable> = []
    private var filterBarButtonItem: UIBarButtonItem!
    
    // MARK: Init
    required
    init(transactionsTableViewDataSource: TransactionsTableViewDataSource,
         transactionsTableViewDelegate: TransactionTableViewDelegate,
         transactionsView: TransactionsView,
         transactionsVM: TransactionsVM,
         filterPopoverVC: FilterPopoverVC) {
        self.transactionsTableViewDataSource = transactionsTableViewDataSource
        self.transactionsTableViewDelegate = transactionsTableViewDelegate
        self.transactionsView = transactionsView
        self.transactionsVM = transactionsVM
        self.filterPopoverVC = filterPopoverVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        [hud].forEach(view.addSubview(_:)) // add HUD on VC
        configTableView()
        setupBindings()
        fetchTransactions()
        setupFilterBarButtonItem()
    }
    
    override func loadView() {
        self.view = transactionsView
        self.title = "Transactions"
    }
    
    // MARK: Functions
    private func fetchTransactions() {
        Task {
            await transactionsVM.fetchTransactions()
        }
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

// MARK: - Setups
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
            .dropFirst()
            .sink {
                [weak self] category in
                self?.transactionsVM.filterTransactions(by: category ?? Constants.clearFilterKey)
            }
            .store(in: &cancelables)
        
        transactionsVM.$filteredTransactions
            .sink {
                [weak self] filteredTransactions in
                self?.transactionsTableViewDataSource.transactions = filteredTransactions
                self?.updateScreen()
            }
            .store(in: &cancelables)
        
        transactionsVM.$summation
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] sum in
                self?.setSummationLabel(sum)
            }
            .store(in: &cancelables)
        
        transactionsTableViewDelegate.$selectedIndexPath
            .sink {
                [weak self] selectedIndexPath in
                guard
                    let sSelf = self,
                    let indexPath = selectedIndexPath,
                    let transaction = self?.transactionsTableViewDataSource.getTransaction(at: indexPath) else { return }
                sSelf.didSelect(transaction: transaction, from: sSelf)
            }
            .store(in: &cancelables)
    }
    
    private func setSummationLabel(_ value: Int) {
        let footerView = transactionsTableViewDelegate.transactionTableViewFooter
        DispatchQueue.main.async {
            footerView.setSummation(value)
        }
    }
}

// MARK: Transactions VM Delegate
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
        showAlert(alertTitle: "Error!", alertMessage: errorMessage)
        transactionsView.hideRetryButton(false)
    }
    
}

// MARK: Transactions VC Coordinator Delegate
extension TransactionsVC: TransactionsVCCoordinatorDelegate {
    func didSelect(transaction: PBTransaction, from controller: UIViewController) {
        transactionsCoordinatorDelegate?.didSelect(transaction: transaction, from: self)
    }
}
