//
//  TableViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

protocol TableViewModel {

    var sections: [TableSection] { get set }
    var dataLoader: DataLaoder { get set }
    
    init(_ controler: MVCTableViewController, with tableView: UITableView)
    
    func setUp(with newData: [Int: TableSection])
    
    func getSection(for section: Int) -> TableSection
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
}

extension TableViewModel {
    
    func getSection(for section: Int) -> TableSection {
        return sections[section]
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].rows[indexPath.row]
    }
}
