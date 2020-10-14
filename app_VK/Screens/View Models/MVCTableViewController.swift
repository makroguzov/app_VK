//
//  MVCTableViewController.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class MVCTableViewController: UITableViewController, DataReloadedController {
        
    var viewModel: TableViewModel!

    func reloadData(with newData: [Int : TableSectionModel]) {
        viewModel.setUp(with: newData)
    }

    override func viewDidLoad() {
        viewModel = TableViewModel(self, with: tableView)
    }

}
