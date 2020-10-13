//
//  UserGroupsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class UserGroupsViewModel: TableViewModel {
    
    var sections: [TableSection] = []
    var dataLoader: DataLaoder
    
    required init(_ controler: MVCTableViewController, with tableView: UITableView) {
        
        let parser = UserGroupsParser(for: tableView)
        dataLoader = UserGroupsDataLoader(parser: parser, controler: controler)
    
    }
    
    func setUp(with newData: [Int : TableSection]) {
        var sections = [TableSection]()
        for section in newData.values {
            sections.append(section)
        }
        
        self.sections = sections
    }
}
