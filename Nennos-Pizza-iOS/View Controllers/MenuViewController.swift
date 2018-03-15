//
//  MenuViewController.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 12/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    class var storyboardIdentifier: String { return "MenuControllerIdentifier" }

    // MARK: Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataSource: MenuDataSource!
    
    // MARK: Models
    let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setup()
        viewModel.loadMenu { completed in
            self.activityIndicator.stopAnimating()
            if completed {
                self.tableView.reloadData()
            } else {
                let alertController = UIAlertController(title: "Oups", message: "We are sorry but there seems to be an issue with our menu :(", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

// MARK:- Setup
extension MenuViewController {
    func setup() {
        dataSource.viewModel = viewModel
        activityIndicator.startAnimating()
    }
}

// MARK:- Navigation
extension MenuViewController {
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.Segue.OpenPiza {
            let destination = segue.destination as! PizzaViewController
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let pizza = viewModel.pizzas![selectedRow]
            let detailViewModel = PizzaDetailViewModel(pizza: pizza, availableIngredients: viewModel.ingredients!)
            destination.viewModel = detailViewModel
            destination.title = pizza.name.uppercased()
        } else if segue.identifier == Constants.Identifiers.Segue.CreatePiza {
            let destination = segue.destination as! PizzaViewController
            //TODO: UX prototype shows 0 but we need a default value, the one from the JSON request
            let customPizza = Pizza(name: "Pizza", ingredientIds: [], basePrice: 4)
            let detailViewModel = PizzaDetailViewModel(pizza: customPizza, availableIngredients: viewModel.ingredients!)
            destination.viewModel = detailViewModel
            destination.title = "CREATE A PIZZA"
        }
     }
}

// MARK:- UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
