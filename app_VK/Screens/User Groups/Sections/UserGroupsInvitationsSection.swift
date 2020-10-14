//
//  UserGroupsInvitationsSection.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import UIKit

class UserGroupsInvitationsSection: TableSectionModel {
 
    override func height(for row: Int) -> CGFloat {
        return GroupsInvitationCell.height
    }
    
}
