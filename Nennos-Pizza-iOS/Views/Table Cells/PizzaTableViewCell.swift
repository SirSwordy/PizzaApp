//
//  PizzaTableViewCell.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 12/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PizzaTableViewCell: UITableViewCell {
    
    class var cellIdentifier: String { return "PizzaCellIdentifier"}
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var pizzaImage: UIImageView!
    
    @IBOutlet weak var pizzaNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    private var pizza: Pizza!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with pizza: Pizza) {
        self.pizza = pizza
        pizzaNameLabel.text = pizza.name
        ingredientsLabel.text = pizza.description
        addToCartButton.setTitle("$" + pizza.price.clean, for: .normal)
        if let imageUrl = pizza.url {
            pizzaImage.af_setImage(withURL: imageUrl)
        }
    }
}

// MARK:- Actions
extension PizzaTableViewCell {
    @IBAction func onAddToCartTouchUpInside(_ sender: Any) {
        CartManager.sharedInstance().addToCart(item: pizza)
    }
}
