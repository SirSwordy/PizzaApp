//
//  PizzaDetailDataSource.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class PizzaDetailDataSource: NSObject, UITableViewDataSource {
    
    @IBOutlet var viewModel: PizzaDetailViewModel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + viewModel.availableIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: PizzaImageTableViewCell.cellIdentifier, for: indexPath) as! PizzaImageTableViewCell
            cell.selectionStyle = .none
            (cell as! PizzaImageTableViewCell).configure(with: viewModel.pizza.url)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCellIdentifier", for: indexPath)
            cell.selectionStyle = .none
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: GenericItemTableViewCell.cellIdentifier, for: indexPath) as! GenericItemTableViewCell
            //TODO: Implement adding/removing ingredients
            cell.selectionStyle = .none
            let ingredient = viewModel.availableIngredients[indexPath.row - 2]
            (cell as! GenericItemTableViewCell).configure(with: ingredient, checked: viewModel.pizzaContains(ingredient: ingredient))
        }
        return cell
    }
}
