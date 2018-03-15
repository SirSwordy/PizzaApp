//
//  PizzaImageTableViewCell.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class PizzaImageTableViewCell: UITableViewCell {
    
    class var cellIdentifier: String { return "PizzaImageCellIdentifier"}
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var pizzaImage: UIImageView!

    func configure(with imageUrl: URL?) {
        if let imageUrl = imageUrl {
            pizzaImage.af_setImage(withURL: imageUrl)
        }
    }
}
