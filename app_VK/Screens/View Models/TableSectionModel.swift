//
//  TableSection.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class TableSectionModel {
    
    private var cells: [UITableViewCell]
    
    init(rows: [UITableViewCell]) {
        
        self.cells = rows
        
    }

    func getCell(at row: Int) -> UITableViewCell {
        return cells[row]
    }
    
    func getCellsCount() -> Int {
        return cells.count
    }
    
    func height(for row: Int) -> CGFloat {
        return 0
    }

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
