//
//  Connectivity.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 21.01.23.
//


import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
