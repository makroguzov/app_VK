//
//  ParseTableDataOperation.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation

class ParseTableDataOperation: Operation {
    
    private var parser: Parser
    var sections = [TableSection]()
 
    init(parser: Parser) {
        self.parser = parser
    }
    
    override func main() {
        guard let data = dependencies.first as? GetDataOperation else {
            print("Some problems with dependencies in class: ParseDataOperation, at function: \(#function).")
            return
        }
        
        if let json = data.json {
            let sections = parser.parseData(with: json)
            self.sections = sections
        } else {
            print("Can't find json in class: ParseDataOperation at function \(#function)")
        }
        
    }
}
