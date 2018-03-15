//
//  PizzaManagerTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
@testable import Nennos_Pizza_iOS

class PizzaManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_it_saves_pizzas() {
        let pizzas = [Pizza(name: "Pizza 1", ingredientIds: [1, 2], imageUrl: nil, basePrice: 7),
                      Pizza(name: "Pizza 2", ingredientIds: [3, 2], imageUrl: nil, basePrice: 6)]
        let pizzaManager: PizzaManagerProtocol = MockPizzaManager()
        pizzaManager.save(pizzas: pizzas)
        let savedPizzas = pizzaManager.pizzas()
        XCTAssertEqual(savedPizzas[0], pizzas[0])
        XCTAssertEqual(savedPizzas[1], pizzas[1])
    }
    
    func test_it_saves_pizzas_with_ingredient_objects() {
        let ingredient1 = Ingredient(id: 1, name: "Tomatoes", price: 2)
        let ingredient2 = Ingredient(id: 2, name: "Cheese", price: 3)
        let ingredient3 = Ingredient(id: 3, name: "Pineapple", price: 3)
        let pizzas = [Pizza(name: "Pizza 1", ingredientIds: [1, 2], imageUrl: nil, basePrice: 7),
                      Pizza(name: "Pizza 2", ingredientIds: [1, 2, 3], imageUrl: nil, basePrice: 6)]
        let pizzaManager: PizzaManagerProtocol = MockPizzaManager()
        pizzaManager.save(pizzas: pizzas, updateIngredients: [ingredient1, ingredient2, ingredient3])
        let savedPizzas = pizzaManager.pizzas()
        XCTAssertEqual(savedPizzas[0].ingredients, [ingredient1, ingredient2])
        XCTAssertEqual(savedPizzas[1].ingredients, [ingredient1, ingredient2, ingredient3])
    }
}
