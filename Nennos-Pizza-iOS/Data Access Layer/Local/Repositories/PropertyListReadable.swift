//
//  PropertyList.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import Foundation

protocol PropertyListReadable {
    func propertyListRepresentation() -> NSDictionary
    init?(propertyListRepresentation: NSDictionary?)
}

extension PropertyListReadable {
    static func extractValuesFromPropertyListArray(propertyListArray: [AnyObject]?) -> [Self] {
        guard let encodedArray = propertyListArray else { return [] }
        return encodedArray.map{ $0 as? NSDictionary }.flatMap{ Self(propertyListRepresentation: $0) }
    }
}
