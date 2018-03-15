//
//  MenuDataSource.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class MenuDataSource: NSObject, UITableViewDataSource {
    
    var viewModel: MenuViewModel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pizzas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PizzaTableViewCell.cellIdentifier, for: indexPath) as! PizzaTableViewCell
        cell.configure(with: viewModel.pizzas![indexPath.row])
        return cell
    }
}
