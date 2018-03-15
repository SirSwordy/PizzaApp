//
//  CartViewController.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 12/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    class var storyboardIdentifier: String { return "CartControllerIdentifier" }
    
    // MARK: Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataSource: CartDataSource!
    @IBOutlet weak var checkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshUI()
    }
}

// MARK:- Setup
extension CartViewController {
    func setup() {
        tableView.register(GenericItemTableViewCell.nib, forCellReuseIdentifier: GenericItemTableViewCell.cellIdentifier)
        tableView.register(CheckoutFooterView.nib, forHeaderFooterViewReuseIdentifier: CheckoutFooterView.reuseIdentifier)
        tableView.reloadData()
    }
    
    func refreshUI() {
        tableView.reloadData()
        enableCheckoutButton(enable: CartManager.sharedInstance().cartItems().count > 0)
    }
}

// MARK:- Actions
extension CartViewController {
    @IBAction func onCheckoutTouchUpInside(_ sender: Any) {
        enableCheckoutButton(enable: false)
        activityIndicator.startAnimating()
        CartManager.sharedInstance().checkout { error in
            self.enableCheckoutButton(enable: true)
            self.activityIndicator.stopAnimating()
            if error == nil {
                let thanksVC = self.storyboard!.instantiateViewController(withIdentifier: ThankYouViewController.storyboardIdentifier)
                self.present(thanksVC, animated: true, completion: {
                    CartManager.sharedInstance().emptyCart()
                    self.refreshUI()
                })
            } else {
                let alertController = UIAlertController(title: "Oups", message: "We seem to be having trouble confirming your order. Please try again.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func enableCheckoutButton(enable: Bool) {
        if enable {
            checkoutButton.isEnabled = true
            checkoutButton.alpha = 1.0
        } else {
            checkoutButton.isEnabled = false
            checkoutButton.alpha = 0.5
        }
    }
}

// MARK:- UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GenericItemTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CheckoutFooterView.reuseIdentifier) as! CheckoutFooterView
        footerView.configure(with: CartManager.sharedInstance().totalPrice)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CheckoutFooterView.height
    }
}
