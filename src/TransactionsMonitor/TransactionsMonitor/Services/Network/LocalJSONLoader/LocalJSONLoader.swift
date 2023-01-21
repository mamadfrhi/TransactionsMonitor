//
//  LocalJSONLoader.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 19.01.23.
//

import Foundation

protocol LocalJSONLoaderInterface {
    func loadJson(filename fileName: String) -> Any?
}

struct LocalJSONLoader: LocalJSONLoaderInterface {
    
    func loadJson(filename fileName: String) -> Any? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let wholeJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                let transactionItemsAny = wholeJSON?["items"]
                return transactionItemsAny
            } catch let error {
                print(error)
                return nil
            }
        }
        return nil
    }
}
