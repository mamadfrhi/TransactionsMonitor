//
//  DetailsVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

class DetailsVC: UIViewController {
    //MARK: Factory
    class func `init`() -> DetailsVC {
        let id = "DetailsView"
        let storyboard = UIStoryboard(name: id, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id) as! DetailsVC
        return vc
    }
}
