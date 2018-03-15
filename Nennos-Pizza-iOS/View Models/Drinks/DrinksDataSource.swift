//
//  DrinksDataSource.swift
//  Nennos-Pizza-iOS
//
//  Created by Sebastian Vancea on 15/03/2018.
//  Copyright © 2018 Sebastian Vancea. All rights reserved.
//

import UIKit

class DrinksDataSource: NSObject, UITableViewDataSource {
    
    @IBOutlet var viewModel: DrinksViewModel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.drinks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenericItemTableViewCell.cellIdentifier, for: indexPath) as! GenericItemTableViewCell
        cell.configure(with: viewModel.drinks![indexPath.row])
        return cell
    }
}
