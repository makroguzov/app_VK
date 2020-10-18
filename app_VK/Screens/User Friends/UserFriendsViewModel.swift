//
//  UserFriendsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 16.10.2020.
//

import UIKit

class UserFriendsViewModel: TableViewModel {
    
    enum Sections: Int {
        case requestsForFriends
        case mostImportant
        case birthdays
        case friends
    }
    
    private var friends = [UserFriendCellModel]()
    private var impFriends =  [UserFriendCellModel]()
    private var birthdays = [UserFriendCellModel]()
    private var requestsForFr = [RequestForFrCellModel]()
    
    var controller: UIViewController
    var tableView: UITableView
    
    var loader = UserFriendsDataLoader()
    
    required init(_ tableView: UITableView, controller: UIViewController) {
        self.controller = controller
        self.tableView = tableView
        
        loader = UserFriendsDataLoader(self)
    }
    
    func numberOfSections() -> Int {
        return 4
    }
    
    func numberOfRowsInSection(section: SectionID) -> Int {
        guard let section = Sections(rawValue: section) else {
            printError(at: #function, error: "Unknown section.")
            return 0
        }
        
        switch section {
        case .birthdays:
            return birthdays.count
        case .friends:
            return friends.count
        case .mostImportant:
            return impFriends.count
        case .requestsForFriends:
            return 1
        }
    }
    
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else {
            printError(at: #function, error: "Unknown section.")
            return UITableViewCell()
        }
        
        #if DEBUG
        print("row: ", indexPath)
        #endif
        
        switch section {
        case .requestsForFriends:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestForFrCell.identifier) as? RequestForFrCell else {
                printError(at: #function, error: "Problems with reuse cell.")
                fatalError()
            }
            
            if indexPath.row > requestsForFr.count || requestsForFr.isEmpty {
                return cell
            }
            
            cell.model = requestsForFr[indexPath.row]
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserFriendCell.identifier) as? UserFriendCell else {
                printError(at: #function, error: "Problems with reuse cell.")
                fatalError()
            }
            
            switch section {
            case .birthdays:
                cell.model = birthdays[indexPath.row]
            case .friends:
                cell.model = friends[indexPath.row]
            case .mostImportant:
                cell.model = impFriends[indexPath.row]
            default:
                printError(at: #function, error: "Unknown section.")
            }
            
            return cell
        }
    }
    
    func insert(models: [SectionID : Any]) {
        for (sectionId, models) in models {
            guard let section = Sections(rawValue: sectionId) else {
                printError(at: #function, error: "Unknown section.")
                return
            }
            
            guard let models = models as? [UserFriendCellModel] else {
                printError(at: #function, error: "Incorrect models type, expected [UserFriendCellModel].")
                return
            }
            
            switch section {
            case .birthdays:
                models.forEach({ birthdays.append($0) })
            case .friends:
                models.forEach({ friends.append($0) })
            case .mostImportant:
                models.forEach({ impFriends.append($0) })
            case .requestsForFriends:
                requestsForFr.append(.forRequests(reqquests: models))
            }
            
            tableView.reloadSections([section.rawValue], with: .automatic)
        }
    }
    
    func update(models: [SectionID : Any]) {
        
    }
    
    func delete(models at: [IndexPath]) {
        
    }
    
    private func printError(at function: String, error: String) {
        print("Error in class: \(#file) at function: \(function). \(error)")
    }
    
}

