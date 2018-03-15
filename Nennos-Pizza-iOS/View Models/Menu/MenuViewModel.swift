//
//  PizzaListViewModel.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class MenuViewModel: NSObject {
    
    var syncManager: SyncManager
    var isLoadingMenu: Bool = false
    
    var ingredients: [Ingredient]?
    var pizzas: [Pizza]?
    
    init(syncManager: SyncManager = SyncManager.sharedInstance()) {
        self.syncManager = syncManager
    }

    func loadMenu(completion: @escaping (Bool) -> Void) {
        isLoadingMenu = true
        syncManager.syncPizzas { (ingredients, pizzas, error) in
            self.isLoadingMenu = false
            self.ingredients = ingredients
            self.pizzas = pizzas
            completion(error == nil)
        }
    }
}
