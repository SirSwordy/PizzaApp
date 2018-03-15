//
//  PizzaLocalRepositoryTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
@testable import Nennos_Pizza_iOS

class PizzaLocalRepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_it_saves_and_loads_pizzas() {
        let defaults = UserDefaults()
        var pizzasRepo: PizzaLocalSaver? = PizzaLocalRepository(defaults: defaults)
        let pizzas = [Pizza(name: "Custom#1", ingredientIds: [1], imageUrl: nil, basePrice: 4, ingredients: [Ingredient(id: 1, name: "Salt", price: 1)]),
                      Pizza(name: "Custom#2", ingredientIds: [1, 2], imageUrl: "x", basePrice: 4, ingredients: [Ingredient(id: 1, name: "Salt", price: 1),
                                                                                                                Ingredient(id: 2, name: "Pepper", price: 2)])]
        pizzasRepo?.savePizzas(pizzas: pizzas)
        pizzasRepo = nil
        pizzasRepo = PizzaLocalRepository(defaults: defaults)
        let savedPizzas = pizzasRepo!.savedPizzas()
        XCTAssertEqual(pizzas, savedPizzas)
    }
}
