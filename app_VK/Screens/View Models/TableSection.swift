//
//  TableSection.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit


protocol TableSectionModel {
    
    var rows: [UITableViewCell] { get set }
    
    init(rows: [UITableViewCell])
    
    func height(for row: Int) -> CGFloat
   
    func viewForHeaderInSection() -> UIView?
    func viewForFooterInSection() -> UIView?

    func titleForHeaderInSection() -> String?
    func titleForFooterInSection() -> String?
    
    func heightForHeaderInSection() -> CGFloat
    func heightForFooterInSection() -> CGFloat

}

extension TableSectionModel {
   
    func viewForHeaderInSection() -> UIView? {
        return nil
    }
    
    func viewForFooterInSection() -> UIView? {
        return nil
    }
    
    func titleForHeaderInSection() -> String? {
        return ""
    }
    
    func titleForFooterInSection() -> String? {
        return ""
    }
    
    func heightForHeaderInSection() -> CGFloat {
        return 0
    }
    
    func heightForFooterInSection() -> CGFloat {
        return 0
    }

}
