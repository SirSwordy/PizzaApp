//
//  RouterTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
@testable import Nennos_Pizza_iOS

class RouterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_paths_are_built_correctly() {
        var route = Router.getIngredients
        XCTAssertEqual(route.path, Constants.API.BaseURL + "/" + Constants.API.ingredients)
        route = Router.getDrinks
        XCTAssertEqual(route.path, Constants.API.BaseURL + "/" + Constants.API.drinks)
        route = Router.getPizzas
        XCTAssertEqual(route.path, Constants.API.BaseURL + "/" + Constants.API.pizzas)
        route = Router.checkout(parameters: [:])
        XCTAssertEqual(route.path, Constants.PostAPI.BaseURL)
    }
    
    func test_methods_are_set_correctly() {
        var route = Router.getIngredients
        XCTAssertEqual(route.method, "GET")
        route = Router.getDrinks
        XCTAssertEqual(route.method, "GET")
        route = Router.getPizzas
        XCTAssertEqual(route.method, "GET")
        route = Router.checkout(parameters: [:])
        XCTAssertEqual(route.method, "POST")
    }
}
