//
//  UserNewsViewController.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

class UserNewsViewController: UITableViewController {
    
    private var viewModel: UserNewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UserNewsViewModel(tableView, controller: self)
    }
    
}
