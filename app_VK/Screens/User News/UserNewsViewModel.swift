//
//  UserNewsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

class UserNewsViewModel: TableViewModel {
    
    enum Errors: Error {
        case UnknownSection(String)
    }
    
    enum Sections {
        case post([Any])
        
        var rows: [Any] {
            switch self {
            case .post(let rows):
                return rows
            }
        }
    }
    
    var tableView: UITableView
    var controller: UIViewController
    
    var dataLoader: UserNewsDataLoader!
    
    private var sections = [Sections]()
    
    
    required init(_ tableView: UITableView, controller: UIViewController) {
        self.tableView = tableView
        self.controller = controller
        
        self.dataLoader = UserNewsDataLoader(viewModel: self)
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfRowsInSection(section: SectionID) -> Int {
        return sections[section].rows.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
       // let rows = getSection(for: indexPath.section).rows
        return UITableViewCell()
    }
    
    func insert(models: [Sections]) {
        
    }
    
    func update(models: [Sections]) {
        
    }
    
    func delete(models at: [IndexPath]) {
        
    }
    
    private func getSection(for section: SectionID) -> Sections {
        if section > sections.count {
            return .post([])
        } else {
            return sections[section]
        }
    }

        
}
