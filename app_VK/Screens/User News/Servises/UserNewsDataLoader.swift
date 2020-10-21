//
//  UserNewsDataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation
import JGProgressHUD

class UserNewsDataLoader {
    
    private var hud = JGProgressHUD(style: .dark)
    private var viewModel: UserNewsViewModel
    
    private var nextFrom: Int = 0
    
    init(viewModel: UserNewsViewModel) {
        self.viewModel = viewModel
    }
    
    func loadData() {
        
    }
}
