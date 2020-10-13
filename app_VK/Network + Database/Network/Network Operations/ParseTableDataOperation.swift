//
//  ParseTableDataOperation.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation

class ParseTableDataOperation: Operation {
    
    private var parser: Parser
    var sections = [Int: TableSection]()
 
    init(parser: Parser) {
        self.parser = parser
    }
    
    override func main() {
        guard let data = dependencies.first as? GetDataOperation else {
            print("Some problems with dependencies in class: ParseDataOperation, at function: \(#function).")
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            let sections = self.parser.parseData(with: data.jsons)
            self.sections = sections
        }
    }
}
