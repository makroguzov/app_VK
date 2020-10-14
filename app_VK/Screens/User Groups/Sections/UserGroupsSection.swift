//
//  UserGroupsSection.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import UIKit

class UserGroupsSection: TableSectionModel {
        
    override func height(for row: Int) -> CGFloat {
        return UserGroupCell.height
    }

    override func heightForHeaderInSection() -> CGFloat {
        return 20
    }
    
    override func titleForHeaderInSection() -> String? {
        return "Группы: \(self.getCellsCount())"
    }
}
