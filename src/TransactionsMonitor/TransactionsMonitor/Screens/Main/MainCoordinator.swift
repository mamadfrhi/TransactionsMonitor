//
//  MainCoordinator.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: Properties
    private let rootNavigationController: UINavigationController
    
    // MARK: Coordinator
    init(rootNavigationController: UINavigationController) { self.rootNavigationController = rootNavigationController }
    
    override func start() {
        super.addChildCoordinator(self)
        let mainVC = ViewController()
        rootNavigationController.pushViewController(mainVC, animated: true)
    }
}

//// MARK: - ViewModel Callbacks
//extension MainCoordinator: MainViewModelCoordinatorDelegate {
//    func didSelect(todoViewData: TodoViewData) {
//        goToDetailsPage(with: todoViewData)
//    }
//
//    func addButtonTapped(from controller: UIViewController) {
//        goToAddPage(from: controller)
//    }
//
//    func editButtonTapped(on todo: TodoObjectType, from controller: UIViewController) {
//        goToEdit(todo: todo, from: controller)
//    }
//}
//
//// MARK: - Navigation
//extension MainCoordinator {
//    private func goToDetailsPage(with todoViewData: TodoViewData) {
//        let detailVC = DetailsVC.`init`(todoViewData: todoViewData)
//        rootNavigationController.present(detailVC,
//                                         animated: true,
//                                         completion: nil)
//    }
//
//    private func goToAddPage(from controller: UIViewController) {
//        guard let mainVC = controller as? MainVC,
//              let mainVM = mainVC.viewModel else { return }
//
//        let addVC = AddVC.`init`(mainVM: mainVM)
//        rootNavigationController.present(addVC,
//                                         animated: true,
//                                         completion: nil)
//    }
//
//    private func goToEdit(todo: TodoObjectType, from controller: UIViewController) {
//        guard let mainVC = controller as? MainVC,
//              let mainVM = mainVC.viewModel else { return }
//
//        let editVC = EditVC.`init`(mainVM: mainVM, todoObject: todo)
//        rootNavigationController.present(editVC,
//                                         animated: true,
//                                         completion: nil)
//    }
//}
