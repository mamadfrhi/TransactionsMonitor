//
//  MainCoordinator.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit

class TransactionsCoordinator: Coordinator {
    
    // MARK: Properties
    private let rootTabBarController: UITabBarController
    private let transactionsNavigationContrller = UINavigationController()
    
    // MARK: Coordinator
    init(rootTabBarController: UITabBarController) { self.rootTabBarController = rootTabBarController }
    
    override func start() {
        super.addChildCoordinator(self)
        
        // TODO: Make Composite Layer to build dependency objects there
        // build dependencies
        let transactionsTableViewDataSource: TransactionsTableViewDataSource = TransactionsTableViewDataSource()
        let transactionsTableViewDelegate: TransactionTableViewDelegate = TransactionTableViewDelegate(transactionTableViewFooter: TransactionTableViewFooter(frame: .zero))
        let transactionsView = TransactionsView(frame: screenBounds)
        let filterPopoverVC = FilterPopoverVC.`init`(list: [])
        
        let transactionsVM = buildTransactionsVM()
        
        let transactionsVC = TransactionsVC(transactionsTableViewDataSource: transactionsTableViewDataSource,
                                            transactionsTableViewDelegate: transactionsTableViewDelegate,
                                            transactionsView: transactionsView,
                                            transactionsVM: transactionsVM,
                                            filterPopoverVC: filterPopoverVC)
        transactionsVC.transactionsCoordinatorDelegate = self
        
        // make tab bar
        let tabBar = UITabBarItem(title: "Transactions",
                                  image: UIImage(systemName: "banknote"), tag: 0)
        transactionsVC.tabBarItem = tabBar
        
        // attach tab bar on tab bar controller
        transactionsNavigationContrller.setViewControllers([transactionsVC], animated: true)
        rootTabBarController.setViewControllers([transactionsNavigationContrller], animated: true)
    }
    
    private func buildTransactionsVM() -> TransactionsVM {
        
        let jsonLoader = LocalJSONLoader()
        let transactionSorter = TransactionsArraySorter()
        
        let session = TransactionsAPISessionManager(with: "Token").getTransactionsSession()
        let transactionAPI = TransactionsAPI(session: session,
                                             localJSONLoader: jsonLoader,
                                             internetChecker: InternetChecker(),
                                             errorsCollection: TransactionsAPIErrors())
        let transactionServices = TransactionServices(transactionsAPI: transactionAPI)
        let transactionsVM = TransactionsVM(services: transactionServices, transactionsSorter: transactionSorter)
        return transactionsVM
        
    }
}

// MARK: - VC Callbacks
extension TransactionsCoordinator: TransactionsVCCoordinatorDelegate {
    func didSelect(transaction: PBTransaction, from controller: UIViewController) {
        goToDetailsPage(with: transaction)
    }
}

// MARK: - Navigation
extension TransactionsCoordinator {
    private func goToDetailsPage(with transaction: PBTransaction) {
        let transactionDetails = TransactionDetails(companyName: transaction.companyName,
                                                    description: transaction.description)
        let detailVC = DetailsVC.`init`(transactionDetails)
        transactionsNavigationContrller.present(detailVC,
                                                animated: true,
                                                completion: nil)
    }
}
