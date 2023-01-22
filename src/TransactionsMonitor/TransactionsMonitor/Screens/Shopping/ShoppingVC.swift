//
//  ShoppingVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 22.01.23.
//

import UIKit

class ShoppingVC: UIViewController {
    
    //MARK: Factory
    class func `init`() -> ShoppingVC {
        let id = "ShoppingView"
        let storyboard = UIStoryboard(name: id, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id) as! ShoppingVC
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}
