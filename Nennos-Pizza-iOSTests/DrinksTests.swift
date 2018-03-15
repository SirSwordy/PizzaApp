//
//  DrinksTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Nennos_Pizza_iOS

class DrinksTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
    }
    
    func test_single_entity_json_mapping() {
        let jsonString = "{\"price\": 1,\"name\": \"Still Water\",\"id\": 1}"
        let json = JSON(parseJSON: jsonString)
        if let drink = Drink(json: json) {
            XCTAssertEqual(drink.price, 1)
            XCTAssertEqual(drink.name, "Still Water")
            XCTAssertEqual(drink.id, 1)
        } else {
            XCTFail()
        }
    }
    
    func test_single_entity_json_mapping_returns_nil_if_property_is_missing() {
        var jsonString = "{\"price\": 1,\"id\": 1}"
        var json = JSON(parseJSON: jsonString)
        var drink = Drink(json: json)
        XCTAssertNil(drink)
        
        jsonString = "{\"name\": \"Still Water\",\"id\": 1}"
        json = JSON(parseJSON: jsonString)
        drink = Drink(json: json)
        XCTAssertNil(drink)
        
        jsonString = "{\"price\": 1,\"name\": \"Still Water\"}"
        json = JSON(parseJSON: jsonString)
        drink = Drink(json: json)
        XCTAssertNil(drink)
    }
    
    func test_collection_json_mapping() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "drinks", withExtension: "json") else {
            XCTFail("Missing file: drinks.json")
            return
        }
        let data = try Data(contentsOf: url)
        let json = try JSON(data: data)
        let drinks = Drink.collection(fromJSON: json)
        XCTAssertEqual(drinks.count, 5)
        XCTAssertEqual(drinks[0].price, 1)
        XCTAssertEqual(drinks[0].name, "Still Water")
        XCTAssertEqual(drinks[0].id, 1)
    }
}
