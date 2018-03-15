//
//  SyncManager.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Alamofire

class SyncManager: NSObject {

    var sessionManager: SessionManager
    var isSyncing: Bool = false
    var error: BackendError? = nil
    
    var ingredientManager: IngredientManagerProtocol
    var drinkManager: DrinkManagerProtocol
    var pizzaManager: PizzaManagerProtocol
    
    class func sharedInstance() -> SyncManager {
        struct Singleton {
            static let _SyncManager = SyncManager(sessionManager: SessionManager.default,
                                                  ingredientManager: IngredientManager(sessionManager: SessionManager.default),
                                                  pizzaManager: PizzaManager(sessionManager: SessionManager.default),
                                                  drinkManager: DrinkManager(sessionManager: SessionManager.default))
        }
        return Singleton._SyncManager
    }
    
    init(sessionManager: SessionManager = SessionManager.default, ingredientManager: IngredientManagerProtocol, pizzaManager: PizzaManagerProtocol, drinkManager: DrinkManagerProtocol)
    {
        self.sessionManager = sessionManager
        self.ingredientManager = ingredientManager
        self.drinkManager = drinkManager
        self.pizzaManager = pizzaManager
    }
    
    func syncPizzas(completion: @escaping (_ ingredients: [Ingredient]?, _ pizzas: [Pizza]?, _ error: BackendError?) -> Void) {
        isSyncing = true
        //TODO: If project scope grows larger, we should use Operations
        let dispatchGroup = DispatchGroup()
        // ingredients
        dispatchGroup.enter()
        ingredientManager.getIngredients { (ingredients, error) in
            if let ingredients = ingredients {
                self.ingredientManager.save(ingredients: ingredients)
            } else {
                self.error = error
            }
            dispatchGroup.leave()
        }
        // pizzas
        dispatchGroup.enter()
        pizzaManager.getPizzas { (pizzas, error) in
            if let pizzas = pizzas {
                self.pizzaManager.save(pizzas: pizzas, updateIngredients: self.ingredientManager.ingredients())
            } else {
                self.error = error
            }
            dispatchGroup.leave()
        }
        // complete
        dispatchGroup.notify(queue: .main) {
            self.isSyncing = false
            completion(self.ingredientManager.ingredients(), self.pizzaManager.pizzas(), self.error)
        }
    }
    
    func syncDrinks(completion: @escaping (_ drinks: [Drink]?, _ error: BackendError?) -> Void) {
        isSyncing = true
        // ingredients
        drinkManager.getDrinks { (drinks, error) in
            if let drinks = drinks {
                self.drinkManager.save(drinks: drinks)
            } else {
                self.error = error
            }
            self.isSyncing = false
            completion(self.drinkManager.drinks(), self.error)
        }
    }
}
