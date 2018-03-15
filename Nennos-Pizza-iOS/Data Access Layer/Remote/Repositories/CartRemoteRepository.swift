//
//  CartRemoteRepository.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Alamofire

class CartRemoteRepository: NSObject {
    class func checkout(parameters: [String : Any], sessionManager: SessionManager, completionHandler: @escaping (_ error: BackendError?) -> Void) {
        sessionManager.request(Router.checkout(parameters: parameters)).validate().responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                print(response.result)
                completionHandler(nil)
            case .failure(let error):
                completionHandler(BackendError.network(error: error))
            }
        })
    }
}
