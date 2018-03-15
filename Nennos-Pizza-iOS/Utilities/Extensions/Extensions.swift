//
//  Extensions.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

extension Double {
    var clean: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        //TODO: A hacky way, but we are trying to show content over the status bar after all :P
        return value(forKey: "statusBar") as? UIView
    }
}

extension UIView {
    func moveAboveTop() {
        self.frame = CGRect(x: 0, y: -self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func moveToTop() {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
}
