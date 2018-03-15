//
//  CartManager.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Alamofire

protocol CartItem: PropertyListReadable {
    var name: String { get }
    var price: Double { get }
}

class CartManager: NSObject {
    
    private var sessionManager: SessionManager
    private var pizzaRepository: PizzaLocalRepository
    private var drinkRepository: DrinkLocalRepository
    private var cart: [CartItem]
    private var addedToCartView: UIView!
    var totalPrice: Double {
        return cart.map{ $0.price }.reduce(0, +)
    }
    
    class func sharedInstance() -> CartManager {
        struct Singleton {
            static let _CartManager = CartManager()
        }
        return Singleton._CartManager
    }
    
    init(sessionManager: SessionManager = SessionManager.default, pizzaRepository: PizzaLocalRepository = PizzaLocalRepository(), drinkRepository: DrinkLocalRepository = DrinkLocalRepository())
    {
        self.sessionManager = sessionManager
        self.pizzaRepository = pizzaRepository
        self.drinkRepository = drinkRepository
        cart = []
        super.init()
        if let addedToCartView = Bundle.main.loadNibNamed("AddedToCartView", owner: self, options: nil)?[0] as? UIView {
            UIApplication.shared.statusBarView?.addSubview(addedToCartView)
            addedToCartView.moveAboveTop()
            self.addedToCartView = addedToCartView
        }
    }
    
    private func pizzas() -> [Pizza] {
        return cart.filter{ $0 is Pizza } as! [Pizza]
    }
    
    private func drinks() -> [Drink] {
        return cart.filter{ $0 is Drink } as! [Drink]
    }
}

// MARK:- Cart Manipulation
extension CartManager {
    //TODO: Should not be able to add incomplete pizzas to cart?
    func addToCart(item: CartItem) {
        cart.append(item)
        UIView.animate(withDuration: 0.25) {
            self.addedToCartView.moveToTop()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.25) {
                self.addedToCartView.moveAboveTop()
            }
        }
        NotificationCenter.default.post(name: Notification.Name.CartUpdated, object: nil)
    }
    
    func removeFromCart(item: CartItem) {
        //TODO: Play around with CartItem and Equatable, might not be a good idea, need to research.
        for i in cart.indices.reversed() where cart[i].name == item.name && cart[i].price == item.price {
            cart.remove(at: i)
            break
        }
        NotificationCenter.default.post(name: Notification.Name.CartUpdated, object: nil)
    }
    
    func emptyCart() {
        cart.removeAll()
        NotificationCenter.default.post(name: Notification.Name.CartUpdated, object: nil)
    }
    
    func cartItems() -> [CartItem] {
        return cart
    }
}

// MARK:- Cart Saving
extension CartManager {
    //TODO: If project scope grows larger then migrate towards CoreData, otherwise UserDefaults is an ok fit.
    func saveCart() {
        pizzaRepository.savePizzas(pizzas: pizzas())
        drinkRepository.saveDrinks(drinks: drinks())
    }
    
    func loadCart() {
        let pizzas = pizzaRepository.savedPizzas()
        for p in pizzas {
            addToCart(item: p)
        }
        let drinks = drinkRepository.savedDrinks()
        for d in drinks {
            addToCart(item: d)
        }
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
