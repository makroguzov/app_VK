//
//  TableSection.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit


protocol TableSection {
    
    var rows: [UITableViewCell] { get set }
    
    init(rows: [UITableViewCell])
    
   
    func viewForHeaderInSection(section: Int) -> UIView?
    func viewForFooterInSection(section: Int) -> UIView?

    func titleForHeaderInSection(section: Int) -> String?
    func titleForFooterInSection(section: Int) -> String?
    
    func heightForHeaderInSection(section: Int) -> CGFloat
    func heightForFooterInSection(section: Int) -> CGFloat

}

extension TableSection {
    func viewForHeaderInSection(section: Int) -> UIView? {
        return nil
    }
    
    func viewForFooterInSection(section: Int) -> UIView? {
        return nil
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        return ""
    }
    
    func titleForFooterInSection(section: Int) -> String? {
        return ""
    }
    
    func heightForHeaderInSection(section: Int) -> CGFloat {
        return 0
    }
    
    func heightForFooterInSection(section: Int) -> CGFloat {
        return 0
    }

}
