//
//  DrinkLocalRepositoryTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
@testable import Nennos_Pizza_iOS

class DrinkLocalRepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_it_saves_and_loads_drinks() {
        let defaults = UserDefaults()
        var drinksRepo: DrinkLocalSaver? = DrinkLocalRepository(defaults: defaults)
        let drinks = [Drink(id: 0, name: "Coke", price: 1.5),
                      Drink(id: 0, name: "Water", price: 1)]
        drinksRepo?.saveDrinks(drinks: drinks)
        drinksRepo = nil
        drinksRepo = DrinkLocalRepository(defaults: defaults)
        let savedDrinks = drinksRepo!.savedDrinks()
        XCTAssertEqual(drinks, savedDrinks)
    }
}
