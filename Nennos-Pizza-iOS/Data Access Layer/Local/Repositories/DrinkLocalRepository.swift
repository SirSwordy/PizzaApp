//
//  DrinkLocalRepository.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Foundation

protocol DrinkLocalSaver {
    func saveDrinks(drinks: [Drink])
    func savedDrinks() -> [Drink]
}

class DrinkLocalRepository: NSObject, DrinkLocalSaver {
    
    let defaults: UserDefaults
    let drinksKey = "DRINKS_KEY"
    
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    func saveDrinks(drinks: [Drink]) {
        let dictionaries = drinks.map{ $0.propertyListRepresentation() }
        defaults.setValue(dictionaries, forKey: drinksKey)
        defaults.synchronize()
        print("Saving drinks \(dictionaries.count)")
    }
    
    func savedDrinks() -> [Drink] {
        let dictionaries = defaults.value(forKey: drinksKey) as? [AnyObject]
        let drinks = Drink.extractValuesFromPropertyListArray(propertyListArray: dictionaries)
        defaults.setValue(nil, forKey: drinksKey)
        defaults.synchronize()
        print("Loading drinks \(drinks.count)")
        return drinks
    }
}
