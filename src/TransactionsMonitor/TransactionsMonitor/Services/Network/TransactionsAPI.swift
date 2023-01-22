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
    
    // API call mocked function
    func fetch() async -> (Result<Any, Error>) {
        
        await delay(secounds: 2)
        
        if raiseFailure() {
            return .failure(TransactionsAPIError.serverError)
        } else {
            if let transactions = localJSONLoader.loadJson(filename: localJSONFileName) {
                return .success(transactions)
            }
            return .failure(TransactionsAPIError.serverError)
        }
    }
    
    // API call real function
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
}

// MARK: Helpers

extension TransactionsAPI {
    
    private func raiseFailure() -> Bool {
        return false
        Bool.random() }
    
    private func delay(secounds: Double) async {
        try! await Task.sleep(nanoseconds: UInt64(secounds * Double(NSEC_PER_SEC)))
    }
    
}


