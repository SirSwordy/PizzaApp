//
//  Serializable.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import SwiftyJSON

protocol Serializable {
    init?(json: JSON)
}
