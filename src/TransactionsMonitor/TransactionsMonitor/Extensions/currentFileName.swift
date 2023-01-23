//
//  currentFileName.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 23.01.23.
//

import Foundation

func currentFileName(fileAddress: String) -> String {
    var fileName = NSString(string: fileAddress).lastPathComponent
    fileName = fileName.components(separatedBy: ".")[0]
    return fileName
}
