//
//  DrinksViewController.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 13/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController {
    
    class var storyboardIdentifier: String { return "DrinksControllerIdentifier" }

    // MARK: Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataSource: DrinksDataSource!
    
    // MARK: Models
    let viewModel = DrinksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.loadDrinks { completed in
            self.activityIndicator.stopAnimating()
            if completed {
                self.tableView.reloadData()
            } else {
                let alertController = UIAlertController(title: "Oups", message: "We are sorry but there seems to be an issue with our drink menu :(", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

// MARK:- Setup
extension DrinksViewController {
    func setup() {
        activityIndicator.startAnimating()
        tableView.register(GenericItemTableViewCell.nib, forCellReuseIdentifier: GenericItemTableViewCell.cellIdentifier)
        dataSource.viewModel = viewModel
    }
}

// MARK:- UITableViewDelegate
extension DrinksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CartManager.sharedInstance().addToCart(item: viewModel.drinks![indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GenericItemTableViewCell.height
    }
}
