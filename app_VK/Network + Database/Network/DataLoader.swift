//
//  DataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation
import Alamofire

class DataLoader {
    
    private let opq = OperationQueue()
    private var controler: DataReloadedController
    private var parser: Parser
    
    init(controler: DataReloadedController, parser: Parser) {
        self.controler = controler
        self.parser = parser
    }
    
    func loadData(with params: VKRequestParametrs) {
        let getDataOperation = GetDataOperation(params: params)
        opq.addOperation(getDataOperation)
        
        let parseDataOperation = ParseTableDataOperation(parser: parser)
        parseDataOperation.addDependency(getDataOperation)
        opq.addOperation(parseDataOperation)
        
        let reloadDataOperation = ReloadDataOperation(controller: controler)
        reloadDataOperation.addDependency(parseDataOperation)
        OperationQueue.main.addOperation(reloadDataOperation)
    }
}
