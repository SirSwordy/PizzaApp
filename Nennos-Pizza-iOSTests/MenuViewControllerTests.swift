//
//  MenuViewControllerTests.swift
//  Nennos-Pizza-iOSTests
//
//  Created by Sebastian Vancea on 14/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import XCTest
@testable import Nennos_Pizza_iOS

class MenuViewControllerTests: XCTestCase {
    
    var viewController: MenuViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: MenuViewController.storyboardIdentifier) as! MenuViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_view_load_sets_model_to_loading() {
        XCTAssertNotNil(viewController.view)
        //TODO: Check if calling like this creates real viewModel zombies
        XCTAssertTrue(viewController.viewModel.isLoadingMenu)
    }
}
