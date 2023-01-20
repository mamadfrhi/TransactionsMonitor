//
//  Network.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 18.01.23.
//

import Foundation

protocol Networkable {
    func fetch(completionHandler: @escaping (Result<Any?, Error>) -> ())
}
