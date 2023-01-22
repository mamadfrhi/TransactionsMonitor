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
        
        let transactionsVC = TransactionsVC()
        transactionsVC.transactionsCoordinatorDelegate = self
        
        let tabBar = UITabBarItem(title: "Transactions",
                                  image: UIImage(systemName: "banknote"), tag: 0)
        transactionsVC.tabBarItem = tabBar
        
        transactionsNavigationContrller.setViewControllers([transactionsVC], animated: true)
        rootTabBarController.setViewControllers([transactionsNavigationContrller], animated: true)
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
