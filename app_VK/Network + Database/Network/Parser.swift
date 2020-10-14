//
//  Parser.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class Parser {
    
    let tableView: UITableView
    
    init(for tableView: UITableView) {
        self.tableView = tableView
    }
    
    func parseData(with jsons: [Int: [String: Any]]) -> [Int: TableSectionModel] {
        return [:]
    }
    
}
