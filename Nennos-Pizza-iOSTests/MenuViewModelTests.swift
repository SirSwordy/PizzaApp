//
//  MenuViewModelTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
@testable import Nennos_Pizza_iOS

class MenuViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_loading_menu_sets_loading_to_true() {
        let syncManager = SyncManager(ingredientManager: MockIngredientManager(), pizzaManager: MockPizzaManager(), drinkManager: MockDrinkManager())
        let menuVM = MenuViewModel(syncManager: syncManager)
        let loadExpectation = expectation(description: "Menu Loaded")
        menuVM.loadMenu { finished in
            loadExpectation.fulfill()
            XCTAssertFalse(menuVM.isLoadingMenu)
        }
        XCTAssertTrue(menuVM.isLoadingMenu)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
