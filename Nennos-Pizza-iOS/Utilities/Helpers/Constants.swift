//
//  Constants.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//


struct Constants {
    
    struct API {
        static let BaseURL = "https://api.myjson.com/bins"
        static let ingredients = "ozt3z"
        static let drinks = "150da7"
        static let pizzas = "dokm7"
    }
        
    struct BackupAPI {
        static let BaseURL = "http://next.json-generator.com/api/json/get"
        static let ingredients = "EkTFDCdsG"
        static let drinks = "N1mnOA_oz"
        static let pizzas = "NybelGcjz"
    }
    
    struct PostAPI {
        static let BaseURL = "http://httpbin.org/post"
    }
    
    struct Params {
        static let id = "id"
        static let name = "name"
        static let price = "price"
        static let pizzas = "pizzas"
        static let basePrice = "basePrice"
        static let ingredients = "ingredients"
        static let imageUrl = "imageUrl"
        static let drinks = "drinks"
    }
    
    struct Identifiers {
        struct Segue {
            static let OpenPiza = "OpenPizzaSegueIdentifier"
            static let CreatePiza = "CreatePizzaSegueIdentifier"
        }
    }
}

