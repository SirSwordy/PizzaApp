//
//  PizzaTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Nennos_Pizza_iOS

class PizzaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_single_entity_json_mapping() {
        let jsonString = "{\"ingredients\": [1,2,7,8],\"name\": \"Hawaii\",\"imageUrl\": \"https://cdn.pbrd.co/images/M57lNSLnC.png\"}"
        let json = JSON(parseJSON: jsonString)
        if let pizza = Pizza(json: json) {
            XCTAssertEqual(pizza.name, "Hawaii")
            XCTAssertEqual(pizza.imageUrl, "https://cdn.pbrd.co/images/M57lNSLnC.png")
            XCTAssertEqual(pizza.ingredientIds.count, 4)
            XCTAssertEqual(pizza.ingredientIds[0], 1)
        } else {
            XCTFail()
        }
    }
    
    func test_single_entity_json_mapping_returns_nil_if_property_is_missing() {
        var jsonString = "{\"ingredients\": [1,2,7,8],\"name\": \"Hawaii\"}"
        var json = JSON(parseJSON: jsonString)
        if let pizza = Pizza(json: json) {
            XCTAssertNotNil(pizza)
            XCTAssertEqual(pizza.name, "Hawaii")
            XCTAssertEqual(pizza.ingredientIds.count, 4)
            XCTAssertEqual(pizza.ingredientIds[0], 1)
        } else {
            XCTFail()
        }

        jsonString = "{\"name\": \"Hawaii\",\"imageUrl\": \"https://cdn.pbrd.co/images/M57lNSLnC.png\"}"
        json = JSON(parseJSON: jsonString)
        var pizza = Pizza(json: json)
        XCTAssertNil(pizza)

        jsonString = "{\"ingredients\": [1,2,7,8],\"imageUrl\": \"https://cdn.pbrd.co/images/M57lNSLnC.png\"}"
        json = JSON(parseJSON: jsonString)
        pizza = Pizza(json: json)
        XCTAssertNil(pizza)
    }

    func test_collection_json_mapping() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "pizzas", withExtension: "json") else {
            XCTFail("Missing file: pizzas.json")
            return
        }
        let data = try Data(contentsOf: url)
        let json = try JSON(data: data)
        let pizzas = Pizza.pizzaCollection(fromJSON: json)
        XCTAssertEqual(pizzas.count, 10)
        XCTAssertEqual(pizzas[0].name, "Margherita")
        XCTAssertEqual(pizzas[0].imageUrl, "https://cdn.pbrd.co/images/M57yElqQo.png")
        XCTAssertEqual(pizzas[0].ingredientIds.count, 2)
        XCTAssertEqual(pizzas[0].ingredientIds[0], 1)
    }
    
    func test_description_is_built_correctly() {
        let ingredient1 = Ingredient(id: 1, name: "Tomatoes", price: 2)
        let ingredient2 = Ingredient(id: 2, name: "Cheese", price: 3)
        let pizza = Pizza(name: "Pizza 1", ingredientIds: [1, 2], imageUrl: nil, basePrice: 6, ingredients: [ingredient1, ingredient2])
        XCTAssertEqual(pizza.description, ingredient1.name + ", " + ingredient2.name)
    }
    
    func test_price_is_calculated_correctly() {
        let ingredient1 = Ingredient(id: 1, name: "Tomatoes", price: 2)
        let ingredient2 = Ingredient(id: 2, name: "Cheese", price: 3)
        let pizza = Pizza(name: "Pizza 1", ingredientIds: [1, 2], imageUrl: nil, basePrice: 6, ingredients: [ingredient1, ingredient2])
        XCTAssertEqual(pizza.price, 11)
    }
}
