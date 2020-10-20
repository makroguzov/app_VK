//
//  UserGroupsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class UserGroupsTableViewModel: TableViewModel {
    
    enum Section {
        case events([GroupsInvitationCellModel])
        case friends([UserGroupCellModel])
    }
    
    var loader = UserGroupsDataLoader()
    
    var tableView: UITableView
    var controller: UIViewController
    
    private var events = [GroupsInvitationCellModel]()
    private var friends = [UserGroupCellModel]()
    
    private var sections = [Section]()
    
    required init(_ tableView: UITableView, controller: UIViewController) {
        self.tableView = tableView
        self.controller = controller
        
        self.loader = UserGroupsDataLoader(viewModel: self, controller: controller)
    }
        
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRowsInSection(section: SectionID) -> Int {
        let section = sections[section]
        
        switch section {
        case .events(let rows):
            return rows.count
        case .friends(let rows):
            return rows.count
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
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
    
    func insert(models: [Section]) {
        for section in models {
            switch section {
            case .events:
                sections.insert(section, at: 0)
                tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            case .friends:
                sections.insert(section, at: 1)
                tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
    }
    
    func update(models: [Section]) {

    }
    
    func delete(models at: [IndexPath]) {
        
    }
    
    private func printError(in function: String, error: String) {
        print("Problems with losding data in class: UserGroupsTableViewModel, at function: \(function). \(error)")
    }
}
