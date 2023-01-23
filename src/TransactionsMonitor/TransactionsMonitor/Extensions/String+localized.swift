//
//  String+localized.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 23.01.23.
//

import Foundation

extension String {
    func localized(fileName: String) -> String {
        
        let table = currentFileName(fileAddress: fileName)
        
        let result = Bundle.main.localizedString(forKey: self,
                                                 value: nil,
                                                 table: table)
        return result
    }
}
