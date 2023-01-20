//
//  ViewController.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 20.01.23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Loaded")
    }

    override func loadView() {
        let vw = UIView(frame: screenBounds)
        vw.backgroundColor = .red
        self.view = vw
    }
}

