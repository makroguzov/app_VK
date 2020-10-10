//
//  MVCTableViewController.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

protocol MVCTableViewController: UIViewController, DataReloadedController {
    
    var viewModel: TableViewModel { get }

}

extension MVCTableViewController {
    func reloadData(with newData: [TableSection]) {
        return
    }
}

