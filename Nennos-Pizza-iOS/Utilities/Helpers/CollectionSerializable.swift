//
//  CollectionSerializable.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import SwiftyJSON

protocol CollectionSerializable {
    static func collection(fromJSON json: JSON) -> [Self] 
}

extension CollectionSerializable where Self: Serializable {
    static func collection(fromJSON json: JSON) -> [Self] {
        var collection: [Self] = []
        if let arrayJSON = json.array {
            for objectJSON in arrayJSON {
                if let item = Self(json: objectJSON) {
                    collection.append(item)
                }
            }
        }
        return collection
    }
}
