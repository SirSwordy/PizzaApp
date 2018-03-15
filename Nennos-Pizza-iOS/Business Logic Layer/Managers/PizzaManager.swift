//
//  PizzaManager.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Alamofire

protocol PizzaManagerProtocol {
    func save(pizzas: [Pizza])
    func save(pizzas: [Pizza], updateIngredients ingredients: [Ingredient])
    func pizzas() -> [Pizza]
    func getPizzas(completionHandler: @escaping (_ drinks: [Pizza]?, _ error: BackendError?) -> Void)
}

extension PizzaManagerProtocol {
    func save(pizzas: [Pizza], updateIngredients ingredients: [Ingredient]) {
        var mutablePizzas = pizzas
        for pizzaIndex in 0..<mutablePizzas.count {
            mutablePizzas[pizzaIndex].setIngredients(ingredients: ingredients.filter { mutablePizzas[pizzaIndex].ingredientIds.contains($0.id) })
        }
        save(pizzas: mutablePizzas)
    }
}

class PizzaManager: NSObject {
    
    //TODO: Local memory storage solution. If project scope grows, we should use CoreData
    fileprivate var savedPizzas: [Pizza] = []
    //    fileprivate let context: NSManagedObjectContext
    
    fileprivate let sessionManager: SessionManager

    init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }
    
    func save(pizzas: [Pizza]) {
        savedPizzas = pizzas
    }
    
    func pizzas() -> [Pizza] {
        return savedPizzas
    }
}

extension PizzaManager: PizzaManagerProtocol {
    func getPizzas(completionHandler: @escaping (_ drinks: [Pizza]?, _ error: BackendError?) -> Void) {
        _ = PizzaRemoteRepository.getPizzas(sessionManager: sessionManager, completionHandler: completionHandler)
    }
}

// MARK:- Mock
class MockPizzaManager: NSObject {
    fileprivate var savedPizzas: [Pizza] = []
}

extension MockPizzaManager: PizzaManagerProtocol {
    func save(pizzas: [Pizza]) {
        savedPizzas = pizzas
    }
    
    func pizzas() -> [Pizza] {
        return savedPizzas
    }
    
    func getPizzas(completionHandler: @escaping (_ drinks: [Pizza]?, _ error: BackendError?) -> Void) {
        let pizza1 = Pizza(name: "Pizza 1", ingredientIds: [1, 2], imageUrl: nil, basePrice: 7)
        let pizza2 = Pizza(name: "Pizza 2", ingredientIds: [4, 2], imageUrl: nil, basePrice: 6)
        completionHandler([pizza1, pizza2], nil)
    }
}
