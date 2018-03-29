//
//  Ingredient.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import SwiftyJSON

struct Ingredient: CollectionSerializable {
    let id: Int
    let name: String
    let price: Double
}

extension Ingredient: Serializable {
    init?(json: JSON) {
        guard let id = json[Constants.Params.id].int else {
            return nil
        }
        guard let name = json[Constants.Params.name].string else {
            return nil
        }
        guard let price = json[Constants.Params.price].double else {
            return nil
        }
        self.id = id
        self.name = name
        self.price = price
    }
}

// MARK:- Coding
extension Ingredient: PropertyListReadable {
    func propertyListRepresentation() -> NSDictionary {
        let representation: [String: AnyObject] = ["id": self.id as AnyObject,
                                                   "name": self.name as AnyObject,
                                                   "price": self.price as AnyObject]
        return representation as NSDictionary
    }
    
    init?(propertyListRepresentation: NSDictionary?) {
        guard let values = propertyListRepresentation else { return nil }
        if let id = values["id"] as? Int,
            let name = values["name"] as? String,
            let price = values["price"] as? Double
        {
            self.id = id
            self.name = name
            self.price = price
        } else {
            return nil
        }
    }
}

extension Ingredient: Equatable {
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.price == rhs.price
    }
}
