//
//  PizzaLocalRepository.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

protocol PizzaLocalSaver {
    func savePizzas(pizzas: [Pizza])
    func savedPizzas() -> [Pizza]
}

class PizzaLocalRepository: NSObject, PizzaLocalSaver {
    
    let defaults: UserDefaults
    let pizzasKey = "PIZZA_KEY"
    
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    func savePizzas(pizzas: [Pizza]) {
        let dictionaries = pizzas.map{ $0.propertyListRepresentation() }
        defaults.setValue(dictionaries, forKey: pizzasKey)
        defaults.synchronize()
        print("Saving pizzas \(dictionaries.count)")
    }
    
    func savedPizzas() -> [Pizza] {
        let dictionaries = defaults.value(forKey: pizzasKey) as? [AnyObject]
        let pizzas = Pizza.extractValuesFromPropertyListArray(propertyListArray: dictionaries)
        defaults.setValue(nil, forKey: pizzasKey)
        defaults.synchronize()
        print("Loading pizzas \(pizzas.count)")
        return pizzas
    }
}
