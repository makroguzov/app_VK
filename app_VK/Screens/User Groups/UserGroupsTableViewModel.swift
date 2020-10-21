//
//  UserGroupsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class UserGroupsTableViewModel: TableViewModel {
        
    enum Sections {
        case events([GroupsInvitationCellModel])
        case friends([UserGroupCellModel])
    }
    
    var loader = UserGroupsDataLoader()
    
    var tableView: UITableView
    var controller: UIViewController
    
    private var events = [GroupsInvitationCellModel]()
    private var friends = [UserGroupCellModel]()
    
    private var sections = [SectionID: Sections]()
    
    required init(_ tableView: UITableView, controller: UIViewController) {
        self.tableView = tableView
        self.controller = controller
        
        self.loader = UserGroupsDataLoader(viewModel: self, controller: controller)
    }
        
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection(section: SectionID) -> Int {
        guard let section = sections[section] else {
            printError(in: #function, error: "Unknown section.")
            return 0
        }
        
        switch section {
        case .events(let rows):
            return rows.count
        case .friends(let rows):
            return rows.count
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        guard let section = sections[indexPath.section] else {
            printError(in: #function, error: "Unknown error.")
            return UITableViewCell()
        }
        
        switch section {
        case .events(let rows):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsInvitationCell.identifier) as? GroupsInvitationCell else {
                fatalError()
            }
            
            cell.model = rows[indexPath.row]
            return cell
        case .friends(let rows):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserGroupCell.identifier) as? UserGroupCell else {
                fatalError()
            }
            
            cell.model = rows[indexPath.row]
            return cell
        }
    }
    
    func insert(models: [Sections]) {
        for section in models {
            switch section {
            case .events:
                sections[0] = section
            case .friends:
                sections[1] = section
            }
        }
        
        tableView.reloadData()
    }
    
    func update(models: [Sections]) {

    }
    
    func delete(models at: [IndexPath]) {
        
    }
    
    private func printError(in function: String, error: String) {
        print("Problems with losding data in class: UserGroupsTableViewModel, at function: \(function). \(error)")
    }
}
