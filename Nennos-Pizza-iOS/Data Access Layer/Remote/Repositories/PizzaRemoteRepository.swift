//
//  PizzasRemoteRepository.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Alamofire
import SwiftyJSON

class PizzaRemoteRepository: NSObject {
    class func getPizzas(sessionManager: SessionManager, completionHandler: @escaping (_ pizzas: [Pizza]?, _ error: BackendError?) -> Void) {
        sessionManager.request(Router.getPizzas).validate().responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let jsonData):
                let json = JSON(jsonData)
                if let error = json.error {
                    completionHandler(nil, BackendError.jsonSerialization(error: error))
                } else {
                    let items = Pizza.pizzaCollection(fromJSON: json)
                    completionHandler(items, nil)
                }
            case .failure(let error):
                completionHandler(nil, BackendError.network(error: error))
            }
        })
    }
}
