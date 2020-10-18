//
//  UserGroupsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class UserGroupsTableViewModel: TableViewModel {
    
    private enum Section: Int {
        case events = 0
        case friends = 1
    }
    
    var loader = UserGroupsDataLoader()
    
    var tableView: UITableView
    var controller: UIViewController
    
    private var events = [GroupsInvitationCellModel]()
    private var friends = [UserGroupCellModel]()
    
    required init(_ tableView: UITableView, controller: UIViewController) {
        self.tableView = tableView
        self.controller = controller
        
        self.loader = UserGroupsDataLoader(viewModel: self, controller: controller)
    }
        
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRowsInSection(section: SectionID) -> Int {
        let section = Section(rawValue: section)
        
        switch section {
        case .events:
            return events.count
        case .friends:
            return friends.count
        default:
            return 0
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)
        
        switch section {
        case .events:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsInvitationCell.identifier) as? GroupsInvitationCell else {
                fatalError()
            }
            
            cell.model = events[indexPath.row]
            return cell
        case .friends:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserGroupCell.identifier) as? UserGroupCell else {
                fatalError()
            }
            
            cell.model = friends[indexPath.row]
            return cell
        default:
            fatalError()
        }
        
    }
    
    func insert(models: [SectionID: Any]) {

        for (sectionId, models) in models {
            let section = Section(rawValue: sectionId)

            switch section {
            case .events:
                guard let events = models as? [GroupsInvitationCellModel] else {
                    printError(in: #function, error: "Cant setup viewModel with [GroupsInvitationCellModel], because of incorrect type.")
                    return
                }
                
                self.events = events
                tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            case .friends:
                guard let friends = models as? [UserGroupCellModel] else {
                    printError(in: #function, error: "Cant setup viewModel with [UserGroupCellModel], because of incorrect type.")
                    return
                }
                
                self.friends = friends
                tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            default:
                printError(in: #function, error: "Incorrect data format.")
                return
            }
        }
    }
    
    func update(models: [SectionID : Any]) {
        
        for (sectionId, models) in models.enumerated() {
            let section = Section(rawValue: sectionId)
            
            switch section {
            case .events:
                guard let events = models.value as? [GroupsInvitationCellModel] else {
                    print("Error in class: UserGroupsViewModel af function: \(#function). Cant setup viewModel with [GroupsInvitationCellModel], because of incorrect type.")
                    return
                }
                
                self.events = events
                
                let insertions = Array(0 ..< events.count)
                let indexPaths = insertions.map { IndexPath(row: $0, section: 0) }
                
                tableView.reloadRows(at: indexPaths, with: .automatic)
                
            case .friends:
                guard let friends = models.value as? [UserGroupCellModel] else {
                    printError(in: #function, error: "Cant setup viewModel with [UserGroupCellModel], because of incorrect type.")
                    return
                }
                
                self.friends = friends
                
                let insertions = Array(0 ..< friends.count)
                let indexPaths = insertions.map { IndexPath(row: $0, section: 1) }
                tableView.reloadRows(at: indexPaths, with: .automatic)
                
            default:
                printError(in: #function, error: "Incorrect data format.")
                return
            }
        }
        
    }
    
    func delete(models at: [IndexPath]) {
        
    }
    
    private func printError(in function: String, error: String) {
        print("Problems with losding data in class: UserGroupsTableViewModel, at function: \(function). \(error)")
    }
}
