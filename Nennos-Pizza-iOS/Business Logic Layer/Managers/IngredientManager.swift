//
//  IngredientManager.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Alamofire

protocol IngredientManagerProtocol {
    func save(ingredients: [Ingredient])
    func ingredients() -> [Ingredient]
    func getIngredients(completionHandler: @escaping (_ drinks: [Ingredient]?, _ error: BackendError?) -> Void)
}

class IngredientManager: NSObject {
    
    //TODO: Local memory storage solution. If project scope grows, we should use CoreData
    fileprivate var savedIngredients: [Ingredient] = []
//    fileprivate let context: NSManagedObjectContext
    
    fileprivate let sessionManager: SessionManager
    
    init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }
    
    func save(ingredients: [Ingredient]) {
        savedIngredients = ingredients
    }
    
    func ingredients() -> [Ingredient] {
        return savedIngredients
    }
}

extension IngredientManager: IngredientManagerProtocol {
    func getIngredients(completionHandler: @escaping (_ drinks: [Ingredient]?, _ error: BackendError?) -> Void) {
        _ = IngredientRemoteRepository.getIngredients(sessionManager: sessionManager, completionHandler: completionHandler)
    }
}

// MARK:- Mock
class MockIngredientManager: NSObject {
    fileprivate var savedIngredients: [Ingredient] = []
}

extension MockIngredientManager: IngredientManagerProtocol {
    func save(ingredients: [Ingredient]) {
        savedIngredients = ingredients
    }
    
    func ingredients() -> [Ingredient] {
        return savedIngredients
    }
    
    func getIngredients(completionHandler: @escaping (_ drinks: [Ingredient]?, _ error: BackendError?) -> Void) {
        let cinnamon = Ingredient(id: 1, name: "Cinnamon", price: 2.5)
        let avocado = Ingredient(id: 2, name: "Avocado", price: 4)
        completionHandler([cinnamon, avocado], nil)
    }
}
