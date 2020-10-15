//
//  UserGroupCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 14.10.2020.
//

import Foundation

struct UserGroupCellModel {
    
    let name: String
    let subtitle: String
    let image: String
    
}

extension UserGroupCellModel {
    static var emptyState: UserGroupCellModel {
        return UserGroupCellModel(name: "", subtitle: "", image: "")
    }
}

extension UserGroupCellModel {
    static func forGroup(_ group: Group) -> UserGroupCellModel {
        return UserGroupCellModel(name: group.name,
                                  subtitle: group.screenName,
                                  image: group.photo100
        )
    }
}
