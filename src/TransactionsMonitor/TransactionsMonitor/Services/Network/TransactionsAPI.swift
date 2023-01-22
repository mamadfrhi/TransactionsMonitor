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
    private let internetChecker   : InternetChecker
    private let localJSONFileName : String
    private let errorsCollection  : TransactionsAPIErrors
    
    internal init(session: Session,
                  localJSONLoader: any LocalJSONLoaderInterface,
                  internetChecker: InternetChecker,
                  jsonFileName: String = "PBTransactions",
                  errorsCollection: TransactionsAPIErrors) {
        self.session = session
        self.localJSONLoader = localJSONLoader
        self.internetChecker = internetChecker
        self.localJSONFileName = jsonFileName
        self.errorsCollection = errorsCollection
    }
}

extension TransactionsAPI: Networkable {
    
    // API call mocked function
    func fetch() async -> (Result<Any, Error>) {
        
        await delay(secounds: 2)
        
        if raiseFailure() {
            return .failure(errorsCollection.serverError)
        } else {
            if let transactions = localJSONLoader.loadJson(filename: localJSONFileName) {
                return .success(transactions)
            }
            return .failure(errorsCollection.serverError)
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
                        completionHandler(.failure(self.errorsCollection.clientError))
                    }
                case .failure:
                    completionHandler(.failure(self.errorsCollection.serverError))
                }
            }
    }
}

// MARK: Helpers

extension TransactionsAPI {
    
    private func raiseFailure() -> Bool { Bool.random() }
    
    private func delay(secounds: Double) async {
        try! await Task.sleep(nanoseconds: UInt64(secounds * Double(NSEC_PER_SEC)))
    }
    
}


