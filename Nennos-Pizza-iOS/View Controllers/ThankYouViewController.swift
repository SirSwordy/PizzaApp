//
//  ThankYouViewController.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 13/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {
    
    class var storyboardIdentifier: String { return "ThankYouControllerIdentifier" }
    
    @IBAction func onTapGesture(_ sender: Any) {
        if let navVC = presentingViewController as? UINavigationController {
            navVC.popToRootViewController(animated: false)
        }
        dismiss(animated: true, completion: nil)
    }
}
