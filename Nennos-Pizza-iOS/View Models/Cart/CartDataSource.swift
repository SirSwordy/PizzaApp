//
//  CartDataSource.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class CartDataSource: NSObject, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.sharedInstance().cartItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenericItemTableViewCell.cellIdentifier, for: indexPath) as! GenericItemTableViewCell
        cell.selectionStyle = .none
        cell.configure(with: CartManager.sharedInstance().cartItems()[indexPath.row])
        return cell
    }

}
