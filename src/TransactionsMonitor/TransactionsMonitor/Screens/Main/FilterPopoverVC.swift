//
//  FilterPopoverVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

protocol FilterPopoverDelegate: AnyObject {
    func filterBy(category: Int)
}

class FilterPopoverVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var list: [String] = []
    weak var delegagte: FilterPopoverDelegate?
    
    //MARK: Factory
    class func `init`(list: [String]) -> FilterPopoverVC {
        let id = "FilterPopoverView"
        let storyboard = UIStoryboard(name: id, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id) as! FilterPopoverVC
        vc.list = list
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

extension FilterPopoverVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}
