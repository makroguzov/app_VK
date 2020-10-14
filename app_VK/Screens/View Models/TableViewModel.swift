//
//  TableViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class TableViewModel {

    enum Errors: Error {
        case InvalidSection(String)
    }
    
    var sections = [TableSectionModel]()
    var dataLoader: DataLaoder
    
    init(_ controler: MVCTableViewController, with tableView: UITableView) {
        
        let parser = UserGroupsParser(for: tableView)
        dataLoader = UserGroupsDataLoader(parser: parser, controler: controler)

    }
    
    func setUp(with newData: [Int: TableSectionModel]) {
        let sections = newData.keys.sorted()
        for section in sections {
            self.sections.append(newData[section]!)
        }
    }
    
    func get(section: Int) -> TableSectionModel {
        return sections[section]
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return sections[section].getCellsCount()
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].getCell(at: indexPath.row)
    }
}
