//
//  CartManagerTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
@testable import Nennos_Pizza_iOS

class CartManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_it_adds_to_cart() {
        let cart = CartManager()
        XCTAssertEqual(cart.cartItems().count, 0)
        let drink = Drink(id: 0, name: "Coke", price: 1.5)
        cart.addToCart(item: drink)
        XCTAssertEqual(cart.cartItems().count, 1)
        XCTAssertEqual(cart.cartItems()[0].name, drink.name)
        XCTAssertEqual(cart.cartItems()[0].price, drink.price)
    }
    
    func test_it_adds_2_of_the_same_item_to_cart() {
        let cart = CartManager()
        XCTAssertEqual(cart.cartItems().count, 0)
        let drink = Drink(id: 0, name: "Coke", price: 1.5)
        cart.addToCart(item: drink)
        cart.addToCart(item: drink)
        XCTAssertEqual(cart.cartItems().count, 2)
        XCTAssertEqual(cart.cartItems()[0].name, drink.name)
        XCTAssertEqual(cart.cartItems()[0].price, drink.price)
        XCTAssertEqual(cart.cartItems()[1].name, drink.name)
        XCTAssertEqual(cart.cartItems()[1].price, drink.price)
    }
    
    func test_it_removes_from_cart() {
        let cart = CartManager()
        let drink = Drink(id: 0, name: "Coke", price: 1.5)
        cart.addToCart(item: drink)
        cart.removeFromCart(item: drink)
        XCTAssertEqual(cart.cartItems().count, 0)
    }
    
    func test_it_removes_only_once_from_cart() {
        let cart = CartManager()
        let drink = Drink(id: 0, name: "Coke", price: 1.5)
        cart.addToCart(item: drink)
        cart.addToCart(item: drink)
        cart.removeFromCart(item: drink)
        XCTAssertEqual(cart.cartItems().count, 1)
        XCTAssertEqual(cart.cartItems()[0].name, drink.name)
        XCTAssertEqual(cart.cartItems()[0].price, drink.price)
    }
    
    func test_it_empties_cart() {
        let cart = CartManager()
        cart.addToCart(item: Drink(id: 0, name: "Coke", price: 1.5))
        cart.addToCart(item: Drink(id: 0, name: "Water", price: 1))
        cart.addToCart(item: Pizza(name: "Custom Pizza", ingredientIds: [1, 2], basePrice: 4))
        XCTAssertEqual(cart.cartItems().count, 3)
        cart.emptyCart()
        XCTAssertEqual(cart.cartItems().count, 0)
    }
}
