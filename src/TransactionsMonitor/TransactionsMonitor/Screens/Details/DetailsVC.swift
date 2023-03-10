//
//  DetailsVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

class DetailsVC: UIViewController {
    
    //MARK: Factory
    class func `init`(_ transactionDetails: TransactionDetails) -> DetailsVC {
        let id = "DetailsView"
        let storyboard = UIStoryboard(name: id, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id) as! DetailsVC
        vc.transactionDetails = transactionDetails
        return vc
    }
    
    // MARK: Properties
    private var transactionDetails: TransactionDetails! = nil
    
    // MARK: Outlets
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        companyLabel.text = transactionDetails.companyName
        descriptionLabel.text = transactionDetails.description ?? "No description"
    }
}
