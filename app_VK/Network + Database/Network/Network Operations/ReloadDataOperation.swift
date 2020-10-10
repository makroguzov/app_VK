//
//  ReloadDataOperation.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation

class ReloadDataOperation: Operation {
    
    private var controller: DataReloadedController
    
    init(controller: DataReloadedController) {
        self.controller = controller
    }
    
    override func main() {
        guard let newData = dependencies.first as? ParseTableDataOperation else {
            print("Some problems with dependencies in class: ReloadDataOperation, at function: \(#function)")
            return
        }
        
        controller.reloadData(with: newData.sections)
    }
}
