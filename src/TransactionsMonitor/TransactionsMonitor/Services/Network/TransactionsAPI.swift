//
//  TransactionAPI.swift
//  TransactionsMonitor
//
//  Created by Mohammad Farrahi on 19.01.23.
//

import Alamofire

struct TransactionsAPI {
    
    private let session           : Session
    private let localJSONLoader   : any LocalJSONLoaderInterface
    private let localJSONFileName = "PBTransactions"
    private let internetChecker = InternetChecker()
    
    internal init(session: Session,
                  localJSONLoader: any LocalJSONLoaderInterface) {
        self.session = session
        self.localJSONLoader = localJSONLoader
    }
}

extension TransactionsAPI: Networkable {
    func fetchRealData(completionHandler: @escaping (Result<Any?, Error>) -> ()) {
        // mimic network request
        let getTransactionsURL = TransactionsAPIRouter.getTransactions
        session
            .request(getTransactionsURL)
            .responseData { response in
                let result = response.result
                switch result {
                case .success(let data):
                    do {
                        let json = try JSONSerialization.jsonObject(with: data)
                        completionHandler(.success(json))
                    } catch {
                        completionHandler(.failure(TransactionsAPIError.clientError))
                    }
                case .failure:
                    completionHandler(.failure(TransactionsAPIError.serverError))
                }
            }
    }
    
    func fetch(completionHandler: @escaping (Result<Any?, Error>) -> ()) {
        
        if !internetChecker.isOnline() {
            completionHandler(.failure(TransactionsAPIError.disconnected))
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            if raiseFailure() {
                completionHandler(.failure(TransactionsAPIError.serverError))
            } else {
                if let transactions = localJSONLoader.loadJson(filename: localJSONFileName) {
                    completionHandler(.success(transactions))
                    return
                }
                completionHandler(.failure(TransactionsAPIError.serverError))
                return
            }
        }
    }
}


extension TransactionsAPI {
    private func raiseFailure() -> Bool {
        return false
        Bool.random() }
}


