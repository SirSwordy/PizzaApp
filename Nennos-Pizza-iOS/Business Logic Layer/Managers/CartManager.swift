//
//  CartManager.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Alamofire

protocol CartItem {
    var name: String { get }
    var price: Double { get }
}

class CartManager: NSObject {
    
    private var sessionManager: SessionManager
    private var cart: [CartItem]
    var totalPrice: Double {
        return cart.map{ $0.price }.reduce(0, +)
    }
    
    class func sharedInstance() -> CartManager {
        struct Singleton {
            static let _CartManager = CartManager()
        }
        return Singleton._CartManager
    }
    
    init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
        cart = []
    }

    //TODO: Should not be able to add incomplete pizzas to cart?
    func addToCart(item: CartItem) {
        cart.append(item)
    }
    
    func removeFromCart(item: CartItem) {
        //TODO: Play around with CartItem and Equatable, might not be a good idea, need to research.
        for i in cart.indices.reversed() where cart[i].name == item.name && cart[i].price == item.price {
            cart.remove(at: i)
            break
        }
    }
    
    func emptyCart() {
        cart.removeAll()
    }
    
    func cartItems() -> [CartItem] {
        return cart
    }
    
    func pizzas() -> [Pizza] {
        return cart.filter{ $0 is Pizza } as! [Pizza]
    }
    
    func drinks() -> [Drink] {
        return cart.filter{ $0 is Drink } as! [Drink]
    }
}

// MARK:- Networking
extension CartManager {
    func checkout(completion: @escaping (_ error: BackendError?) -> Void) {
        let pizzaParameters = pizzas().map{ $0.asParameters() }
        let drinkParameters = drinks().map{ $0.id }
        let cartParameters = [Constants.Params.pizzas : pizzaParameters,
                              Constants.Params.drinks : drinkParameters] as [String : Any]
        CartRemoteRepository.checkout(parameters: cartParameters, sessionManager: sessionManager) { error in
            completion(error)
        }
    }
}
