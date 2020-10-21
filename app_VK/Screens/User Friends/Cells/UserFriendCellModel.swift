//
//  UserFriendCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 16.10.2020.
//

import Foundation

struct UserFriendCellModel {
    
    let name: String
    let image: String
    let bDate: Date?
    
}

extension UserFriendCellModel {
    static var emptyState: UserFriendCellModel {
        return UserFriendCellModel(name: "",
                                   image: "",
                                   bDate: nil)
    }
}

extension UserFriendCellModel {
    static func forFriend(_ friend: User) -> UserFriendCellModel {
        return UserFriendCellModel(name: "\(friend.firstName) \(friend.lastName)",
                                   image: friend.photo100 ?? "",
                                   bDate: friend.bdate ?? nil)
    }
}
