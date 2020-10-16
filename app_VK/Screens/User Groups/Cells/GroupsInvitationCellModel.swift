//
//  GroupsInvitationCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 15.10.2020.
//

import Foundation

struct Creator {
    
    let name: String
    let image: String
    
    init(group: Group) {
        name = group.name
        image = group.photo100
    }
    
    init(profile: User) {
        name = "\(profile.firstName) \(profile.lastName)"
        image = profile.photo100 ?? ""
    }
}

struct GroupsInvitationCellModel {
    
    let eventImage: String
    let invitorImage: String
    let evenName: String
    let invitorName: String
  
}

extension GroupsInvitationCellModel {
    static var emptyState: GroupsInvitationCellModel {
        return GroupsInvitationCellModel(eventImage: "", invitorImage: "", evenName: "", invitorName: "")
    }
}

extension GroupsInvitationCellModel {
    static func forEvent(event: Group, invitor: Creator) -> GroupsInvitationCellModel {
        return GroupsInvitationCellModel(eventImage: event.photo100,
                                         invitorImage: invitor.image,
                                         evenName: event.name,
                                         invitorName: invitor.name
        )
    }
}
