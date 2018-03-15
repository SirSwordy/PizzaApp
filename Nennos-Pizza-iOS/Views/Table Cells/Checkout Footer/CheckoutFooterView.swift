//
//  CheckoutFooterView.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 13/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class CheckoutFooterView: UITableViewHeaderFooterView {
    
    class var reuseIdentifier: String { return "CheckoutFooterIdentifier" }
    class var nib: UINib { return UINib(nibName: "CheckoutFooterView", bundle: nil) }
    class var height: CGFloat { return 68.0 }
    
    @IBOutlet weak var totalPriceLabel: UILabel!

    func configure(with price: Double) {
        totalPriceLabel.text = "$" + price.clean
    }
}
