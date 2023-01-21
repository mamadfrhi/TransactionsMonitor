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
//        let detailVC = DetailsVC.`init`(todoViewData: todoViewData)
//        rootNavigationController.present(detailVC,
//                                         animated: true,
//                                         completion: nil)
    }
}
