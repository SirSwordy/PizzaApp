//
//  MockRouter.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Foundation
import Alamofire

enum Router {
    case getIngredients
    case getDrinks
    case getPizzas
    case checkout(parameters: Parameters)
    
    static let baseURLString = Constants.API.BaseURL
    
    var method: String {
        switch self {
        case .getIngredients:
            return "GET"
        case .getDrinks:
            return "GET"
        case .getPizzas:
            return "GET"
        case .checkout:
            return "POST"
        }
    }
    
    var path: String {
        switch self {
        case .getIngredients:
            return Router.baseURLString + "/" + Constants.API.ingredients
        case .getDrinks:
            return Router.baseURLString + "/" + Constants.API.drinks
        case .getPizzas:
            return Router.baseURLString + "/" + Constants.API.pizzas
        case .checkout:
            return Constants.PostAPI.BaseURL
        }
    }
}

extension Router: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: path.asURL())
        urlRequest.httpMethod = method
        
        switch self {
        case .checkout(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        
        return urlRequest
    }
}
