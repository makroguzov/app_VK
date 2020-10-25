//
//  GroupsInvitationCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 15.10.2020.
//

import Foundation

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
