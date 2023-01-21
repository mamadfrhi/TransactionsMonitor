//
//  UIViewController+showAlert.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

extension UIViewController {
    func showAlert(alertTitle : String, alertMessage : String) {
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
