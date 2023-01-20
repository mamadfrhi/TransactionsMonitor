//
//  TransactionAPISessionManager.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 18.01.23.
//

import Alamofire

class TransactionsAPISessionManager {
    
    private let session: Session
    
    init(with token: String) {
        
        // MARK: Config
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        
        // MARK: Interceptor -> the module is open to adapt with an Interceptor!
        // let interceptor = LoggerAPIInterceptor(token: token)
        
        session = Session(configuration: configuration)
    }
    
    func getTransactionsSession() -> Session { session }
}
