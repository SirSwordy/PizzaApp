//
//  DrinkManager.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Alamofire

protocol DrinkManagerProtocol {
    func save(drinks: [Drink])
    func drinks() -> [Drink]
    func getDrinks(completionHandler: @escaping (_ drinks: [Drink]?, _ error: BackendError?) -> Void)
}

class DrinkManager: NSObject {
    
    //TODO: Local memory storage solution. If project scope grows, we should use CoreData
    fileprivate var savedDrinks: [Drink] = []
//    fileprivate let context: NSManagedObjectContext
    
    fileprivate let sessionManager: SessionManager
    
    init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }

    func save(drinks: [Drink]) {
        savedDrinks = drinks
    }
    
    func drinks() -> [Drink] {
        return savedDrinks
    }
}

extension DrinkManager: DrinkManagerProtocol {
    func getDrinks(completionHandler: @escaping (_ drinks: [Drink]?, _ error: BackendError?) -> Void) {
        _ = DrinkRemoteRepository.getDrinks(sessionManager: sessionManager, completionHandler: { (drinks, error) in
            completionHandler(drinks, error)
        })
    }
}

// MARK:- Mock
class MockDrinkManager: NSObject {
    fileprivate var savedDrinks: [Drink] = []
}

extension MockDrinkManager: DrinkManagerProtocol {
    func save(drinks: [Drink]) {
        savedDrinks = drinks
    }
    
    func drinks() -> [Drink] {
        return savedDrinks
    }
    
    func getDrinks(completionHandler: @escaping (_ drinks: [Drink]?, _ error: BackendError?) -> Void) {
        let milk = Drink(id: 1, name: "Milk", price: 2)
        let wine = Drink(id: 2, name: "Wine", price: 4)
        completionHandler([milk, wine], nil)
    }
}
