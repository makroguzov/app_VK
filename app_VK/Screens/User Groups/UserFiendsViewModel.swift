//
//  UserFiendsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class UserGroupsViewModel: TableViewModel {
    
    var sections: [TableSection] = []
    var dataLoader: DataLoader
    
    init(controler: DataReloadedController) {
        
        let parser = UserGroupsParser()
        dataLoader = DataLoader(controler: controler, parser: parser)
    
    }
    
}
