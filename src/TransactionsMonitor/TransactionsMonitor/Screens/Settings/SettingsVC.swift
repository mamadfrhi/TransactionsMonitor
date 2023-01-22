//
//  SettingsVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 22.01.23.
//

import UIKit

class SettingsVC: UIViewController {

    //MARK: Factory
    class func `init`() -> SettingsVC {
        let id = "SettingsView"
        let storyboard = UIStoryboard(name: id, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id) as! SettingsVC
        return vc
    }
    
}
