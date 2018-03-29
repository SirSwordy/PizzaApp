//
//  PizzaViewModel.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class PizzaDetailViewModel: NSObject {
    
    var pizza: Pizza
    var availableIngredients: [Ingredient]
    
    init(pizza: Pizza, availableIngredients: [Ingredient]) {
        self.pizza = pizza
        self.availableIngredients = availableIngredients
    }

    func pizzaContains(ingredient: Ingredient) -> Bool {
        return pizza.contains(ingredient: ingredient)
    }
}
