//
//  NetworkError.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Foundation
import Alamofire

enum BackendError: Error {
    case network(error: Error)
    case authorization(error: Error)
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

//TODO: Finish implementing
struct NetworkError {
    
    fileprivate var error: NSError?
    var errorCode: Code
    
    init(error: NSError?) {
        self.error = error
        if let error = error {
            if let code = Code(rawValue: error.code) {
                errorCode = code
            } else {
                errorCode = .unknown
            }
        } else {
            errorCode = .unknown
        }
    }
    
    init(code: Int) {
        errorCode = Code.unknown
        if let code = Code(rawValue: code) {
            errorCode = code
        }
    }
    
    enum Code: Int {
        case ok = 200
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case requestTimeout = 408
        case conflict = 409
        case internalServerError = 500
        case badGateway = 502
        case serviceUnavailable = 503
        case gatewayTimeout = 504
        case unknown
        //CFNetworkErrors
        case canceled = -999
        case notConnectedToInternet = -1009
    }
    
    func message() -> String {
        if !(NetworkReachabilityManager()?.isReachable ?? false) {
            return "No internet connection."
        }
        
        switch errorCode {
        case .ok, .badRequest, .forbidden, .notFound,
             .requestTimeout, .internalServerError, .badGateway,
             .serviceUnavailable, .gatewayTimeout:
            return "It looks like a problem has occurred. Please wait a few minutes and try again. Contact us if you continue to experience this problem."
        case .unauthorized:
            return "The username and password you entered don't match our records. Please try again."
        case .notConnectedToInternet:
            return "No internet connection."
        default:
            return "It looks like a problem has occurred. Please wait a few minutes and try again. Contact us if you continue to experience this problem."
        }
    }
}
