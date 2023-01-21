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
        self.view = mainView
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
extension MainVC {
    private func configTableView() {
        mainView.tableView.dataSource = mainTableViewDataSource
    }
    
    private func setupBindings() {
        mainVM.$transactions
            .sink {
                [weak self] transactions in
                self?.mainTableViewDataSource.transactions = transactions
            }
            .store(in: &cancelables)
        
        mainVM.$errorMessage
            .dropFirst()
            .sink {
                [weak self] errorMessage in
                let errorText = errorMessage ?? "Something wrong happened"
                self?.showError(errorMessage: errorText)
            }
            .store(in: &cancelables)
    }
}

// MARK: MainVMDelegate
extension MainVC: MainVMDelegate {
    func updateScreen() {
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
            self.mainView.hideRetryButton(true)
        }
    }
    
    func hud(show: Bool) {
        DispatchQueue.main.async {
            show ? self.hud.show() : self.hud.hide()
        }
    }
    
    func showError(errorMessage: String) {
        DispatchQueue.main.async {
            self.showAlert(alertTitle: "Error!", alertMessage: errorMessage)
            self.mainView.hideRetryButton(false)
        }
    }
    
    func selectedTransationRow() -> Int {
        print("Selected row is: ", mainView.tableView.indexPathForSelectedRow?.row as Any)
        return 0
    }
    
    
}
