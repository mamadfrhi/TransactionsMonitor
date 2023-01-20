//
//  LocalJSONLoader.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 19.01.23.
//

import Foundation

protocol LocalJSONLoaderInterface {
    associatedtype T
    func loadJson(filename fileName: String) -> [T]?
}

struct LocalJSONLoader: LocalJSONLoaderInterface {
    
    func loadJson(filename fileName: String) -> [PBTransaction]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                if let wholeJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let transactionItemsAny = wholeJSON["items"] {
                    let transactionItemsData = try JSONSerialization.data(withJSONObject: transactionItemsAny)
                    let decoder = JSONDecoder()
                    let transactions = try decoder.decode(Array<PBTransaction>.self, from: transactionItemsData)
                    return transactions
                }
            } catch let error {
                print(error)
                return nil
            }
        }
        return nil
    }
}
