//
//  IngredientsTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Nennos_Pizza_iOS

class IngredientsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_single_entity_json_mapping() {
        let jsonString = "{\"price\": 1.5,\"name\": \"Salami\",\"id\": 3}"
        let json = JSON(parseJSON: jsonString)
        if let ingredient = Ingredient(json: json) {
            XCTAssertEqual(ingredient.price, 1.5)
            XCTAssertEqual(ingredient.name, "Salami")
            XCTAssertEqual(ingredient.id, 3)
        } else {
            XCTFail()
        }
    }
    
    func test_single_entity_json_mapping_returns_nil_if_property_is_missing() {
        var jsonString = "{\"price\": 1.5,\"id\": 3}"
        var json = JSON(parseJSON: jsonString)
        var ingredient = Ingredient(json: json)
        XCTAssertNil(ingredient)
        
        jsonString = "{\"name\": \"Salami\",\"id\": 3}"
        json = JSON(parseJSON: jsonString)
        ingredient = Ingredient(json: json)
        XCTAssertNil(ingredient)
        
        jsonString = "{\"price\": 1.5,\"name\": \"Salami\"}"
        json = JSON(parseJSON: jsonString)
        ingredient = Ingredient(json: json)
        XCTAssertNil(ingredient)
    }
    
    func test_collection_json_mapping() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "ingredients", withExtension: "json") else {
            XCTFail("Missing file: ingredients.json")
            return
        }
        let data = try Data(contentsOf: url)
        let json = try JSON(data: data)
        let ingredients = Ingredient.collection(fromJSON: json)
        XCTAssertEqual(ingredients.count, 10)
        XCTAssertEqual(ingredients[2].price, 1.5)
        XCTAssertEqual(ingredients[2].name, "Salami")
        XCTAssertEqual(ingredients[2].id, 3)
    }
}
