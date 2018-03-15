//
//  GenericItemTableViewCell.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 13/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class GenericItemTableViewCell: UITableViewCell {
    
    class var cellIdentifier: String { return "GenericCellIdentifier"}
    class var nib: UINib { return UINib(nibName: "GenericItemTableViewCell", bundle: nil) }
    class var height: CGFloat { return 44.0 }

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        actionButton.isUserInteractionEnabled = false
        actionButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with name: String, price: Double) {
        nameLabel.text = name
        priceLabel.text = "$" + price.clean
    }
    
    func configure(with ingredient: Ingredient, checked: Bool) {
        self.configure(with: ingredient.name, price: ingredient.price)
        actionButton.setImage(UIImage(named: "sample_checkmark"), for: .normal)
        actionButton.isHidden = !checked
    }
    
    func configure(with drink: Drink) {
        self.configure(with: drink.name, price: drink.price)
        actionButton.setImage(UIImage(named: "sample_add"), for: .normal)
        actionButton.isHidden = false
    }
    
    func configure(with cartItem: CartItem) {
        self.configure(with: cartItem.name, price: cartItem.price)
        actionButton.setImage(UIImage(named: "sample_remove"), for: .normal)
        actionButton.isHidden = false
        actionButton.isUserInteractionEnabled = true
    }
    
    @IBAction func onButtonTouchUpInside(_ sender: Any) {
    }
}
