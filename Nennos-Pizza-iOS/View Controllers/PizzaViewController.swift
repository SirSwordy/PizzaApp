//
//  PizzaViewController.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 13/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit
import AlamofireImage

class PizzaViewController: UIViewController {
    
    class var storyboardIdentifier: String { return "PizzaControllerIdentifier" }
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet var dataSource: PizzaDetailDataSource!
    
    // MARK: Models
    var viewModel: PizzaDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK:- Setup
extension PizzaViewController {
    func setup() {
        tableView.register(GenericItemTableViewCell.nib, forCellReuseIdentifier: GenericItemTableViewCell.cellIdentifier)
        dataSource.viewModel = viewModel
        title = viewModel.pizza.name.uppercased()
        addToCartButton.setTitle("ADD TO CART ($" + viewModel.pizza.price.clean + ")", for: .normal)
        tableView.reloadData()
    }
}

// MARK:- Actions
extension PizzaViewController {
    @IBAction func onAddToCartTouchUpInside(_ sender: Any) {
        CartManager.sharedInstance().addToCart(item: viewModel.pizza)
    }
}

// MARK:- UITableViewDelegate
extension PizzaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.row > 1 else {
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 65
        default:
            return GenericItemTableViewCell.height
        }
    }
}
