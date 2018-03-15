//
//  DrinksViewModel.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class DrinksViewModel: NSObject {
    
    var syncManager: SyncManager
    var isLoadingDrinks: Bool = false
    
    var drinks: [Drink]?
    
    init(syncManager: SyncManager = SyncManager.sharedInstance()) {
        self.syncManager = syncManager
    }
    
    func loadDrinks(completion: @escaping (Bool) -> Void) {
        isLoadingDrinks = true
        syncManager.syncDrinks { (drinks, error) in
            self.isLoadingDrinks = false
            self.drinks = drinks
            completion(error == nil)
        }
    }
}
