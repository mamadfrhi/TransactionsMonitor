//
//  FilterPopoverVC.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//

import UIKit

class FilterPopoverVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var list: [String] = []
    
    @Published var chosenCategory: String?
    
    //MARK: Factory
    class func `init`(list: [String]) -> FilterPopoverVC {
        let id = "FilterPopoverView"
        let storyboard = UIStoryboard(name: id, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id) as! FilterPopoverVC
        vc.list = list
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        list.append(Constants.clearFilterKey)
        tableView.reloadData()
    }
    
}

extension FilterPopoverVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = list[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCategory = list[indexPath.row]
        self.dismiss(animated: true)
    }
}
