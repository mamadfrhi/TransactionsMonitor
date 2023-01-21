//
//  MainCoordinator.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit

class TransactionsCoordinator: Coordinator {
    
    // MARK: Properties
    private let rootNavigationController: UINavigationController
    
    // MARK: Coordinator
    init(rootNavigationController: UINavigationController) { self.rootNavigationController = rootNavigationController }
    
    override func start() {
        super.addChildCoordinator(self)
        let transactionsVC = TransactionsVC()
        transactionsVC.transactionsCoordinatorDelegate = self
        rootNavigationController.pushViewController(transactionsVC, animated: true)
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
        print("go to details with \(transaction)")
        let detailVC = DetailsVC.`init`()
        rootNavigationController.present(detailVC,
                                         animated: true,
                                         completion: nil)
    }
}
