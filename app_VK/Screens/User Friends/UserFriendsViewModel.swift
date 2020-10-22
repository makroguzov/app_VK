//
//  UserFriendsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 16.10.2020.
//

import UIKit

class UserFriendsViewModel: TableViewModel {

    enum Sections {
        case requestsForFriends([RequestForFrCellModel])
        case mostImportant([UserFriendCellModel])
        case birthdays([UserFriendCellModel])
        case friends([UserFriendCellModel])
    }
    
    private var sections = [Sections]()
    
    var controller: UIViewController
    var tableView: UITableView
    
    var loader = UserFriendsDataLoader()
    
    required init(_ tableView: UITableView, controller: UIViewController) {
        self.controller = controller
        self.tableView = tableView
        
        loader = UserFriendsDataLoader(self)
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection(section: SectionID) -> Int {
        let section = sections[section]
        
        switch section {
        case .birthdays(let rows):
            return rows.count
        case .friends(let rows):
            return rows.count
        case .mostImportant(let rows):
            return rows.count
        case .requestsForFriends(let rows):
            return rows.count
        }
    }
        
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
       
        switch section {
        case .birthdays(let rows):
            let cell = getUserFriendCell()
            
            cell.model = rows[indexPath.row]
            return cell
        case .friends(let rows):
            let cell = getUserFriendCell()
            
            cell.model = rows[indexPath.row]
            return cell
        case .requestsForFriends(let rows):
            let cell = getRequestForFrCell()
            
            cell.model = rows[indexPath.row]
            return cell
        case .mostImportant(let rows):
            let cell = getUserFriendCell()
            
            cell.model = rows[indexPath.row]
            return cell
        }
    }
        
    private func getRequestForFrCell() -> RequestForFrCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestForFrCell.identifier) as? RequestForFrCell else {
            printError(at: #function, error: "Problems with reuse cell.")
            fatalError()
        }

        return cell
    }
    
    private func getUserFriendCell() -> UserFriendCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserFriendCell.identifier) as? UserFriendCell else {
            printError(at: #function, error: "Problems with reuse cell.")
            fatalError()
        }
        
        return cell
    }
    
    func insert(models: [Sections]) {
        sections = models
        tableView.reloadData()
    }
    
    func update(models: [Sections]) {
        
    }
    
    func delete(models at: [IndexPath]) {
        
    }
        
}

