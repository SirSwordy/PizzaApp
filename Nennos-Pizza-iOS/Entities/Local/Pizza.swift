//
//  Pizza.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import SwiftyJSON

struct Pizza: CartItem {
    var name: String
    let ingredientIds: [Int]
    let imageUrl: String?
    var url: URL? {
        guard let imageUrl = imageUrl else {
            return nil
        }
        return URL(string: imageUrl)
    }
    let basePrice: Double
    //TODO: Pizza ingredients should be set on init. Would be cleaner if we differentiate between Local and Remote Pizza object.
    var ingredients: [Ingredient] = []
    var description: String {
        let string = ingredients.map{ $0.name }.joined(separator: ", ")
        return string
    }
    var price: Double {
        let price = ingredients.map{ $0.price }.reduce(basePrice, +)
        return price
    }
    fileprivate var nameWasEdited = false
    
    init(name: String, ingredientIds: [Int], imageUrl: String? = nil, basePrice: Double, ingredients: [Ingredient] = []) {
        self.name = name
        self.ingredientIds = ingredientIds
        self.imageUrl = imageUrl
        self.basePrice = basePrice
        self.ingredients = ingredients
    }
    
    //TODO: This method can scale towards a PizzaResponse which can parse the basePrice and then call Pizza.collection()
    static func pizzaCollection(fromJSON json: JSON) -> [Pizza] {
        var collection: [Pizza] = []
        //TODO: Should we show pizzas even when we have no basePrice? Set a default basePrice in the app for better UX?
        if let price = json[Constants.Params.basePrice].double, let pizzaArrayJSON = json[Constants.Params.pizzas].array {
            for pizzaJSON in pizzaArrayJSON {
                if let item = self.init(json: pizzaJSON, basePrice: price) {
                    collection.append(item)
                }
            }
        }
        return collection
    }
    
    mutating func setIngredients(ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
    
    func contains(ingredient: Ingredient) -> Bool {
        return ingredients.filter { $0 == ingredient }.count == 1
    }
    
    mutating func updateWith(ingredient: Ingredient) {
        if contains(ingredient: ingredient) {
            remove(ingredient: ingredient)
        } else {
            add(ingredient: ingredient)
        }
        if !nameWasEdited {
            nameWasEdited = true
            let newName = "Custom " + name
            name = newName
        }
    }
    
    mutating func add(ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    mutating func remove(ingredient: Ingredient) {
        for i in ingredients.indices where ingredients[i] == ingredient {
            ingredients.remove(at: i)
            break
        }
    }
}

// MARK:- Serializable
extension Pizza: Serializable {
    init?(json: JSON) {
        self.init(json: json, basePrice: 0)
    }
    
    init?(json: JSON, basePrice: Double) {
        guard let name = json[Constants.Params.name].string else {
            return nil
        }
        guard let ingredientIds = json[Constants.Params.ingredients].arrayObject as? [Int] else {
            return nil
        }
        self.name = name
        self.ingredientIds = ingredientIds
        self.imageUrl = json[Constants.Params.imageUrl].string
        self.basePrice = basePrice
    }
}

// MARK:- Remote
extension Pizza {
    func asParameters() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary[Constants.Params.name] = name
        dictionary[Constants.Params.ingredients] = ingredients.map{ $0.id }
        dictionary[Constants.Params.imageUrl] = imageUrl
        return dictionary
    }
}

// MARK:- Equatable
extension Pizza: Equatable {
    static func ==(lhs: Pizza, rhs: Pizza) -> Bool {
        return lhs.name == rhs.name &&
                lhs.ingredientIds == rhs.ingredientIds &&
                lhs.imageUrl == rhs.imageUrl &&
                lhs.basePrice == rhs.basePrice &&
                lhs.ingredients == rhs.ingredients
    }
}
