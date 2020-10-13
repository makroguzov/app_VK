//
//  UserGroupsInvitationsSection.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import UIKit

class UserGroupsInvitationsSection: TableSection {
    
    var rows: [UITableViewCell]
    
    required init(rows: [UITableViewCell]) {
        self.rows = rows
    }
}
