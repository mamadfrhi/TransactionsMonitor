//
//  TransactionAPIRouter.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 18.01.23.
//

import Alamofire

enum TransactionsAPIRouter: URLRequestConvertible {
    
    // MARK: - CASES
    case getTransactions
    
    // MARK: - PATHS
    var path: String {
        switch self {
        case .getTransactions:
            return "transactions/"
        }
    }
    
    // MARK: - METHODS
    var method: HTTPMethod {
        return .get
    }
    
    // MARK: - FACTORY METHOD
    func asURLRequest() throws -> URLRequest {
        
        // make URL request
        var requestURL = URLRequest(url: Constants.server.rootURL.appendingPathComponent(path))
        requestURL.httpMethod = method.rawValue
        
        // add headers
        requestURL.addValue("Content-Type", forHTTPHeaderField: "application/json")
        
        return requestURL
    }
}
