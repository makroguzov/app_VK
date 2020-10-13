//
//  NetworkManager.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation
import Alamofire
import JGProgressHUD

class NetworkManager {
    
    private let queue = OperationQueue()
    private let progressHud = JGProgressHUD(style: .dark)
    
    private var controler: DataReloadedController
    private var parser: Parser
    
    init(parser: Parser, controler: DataReloadedController) {
        self.controler = controler
        self.parser = parser
    }
    
    func loadData(with params: [VKRequestParametrs]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.progressHud.show(in: self.controler.view, animated: true)
        }
        
        let getDataOperation = GetDataOperation(params: params)
        queue.addOperation(getDataOperation)

        let parseDataOperation = ParseTableDataOperation(parser: parser)
        parseDataOperation.addDependency(getDataOperation)
        queue.addOperation(parseDataOperation)        
        
        let reloadDataOperation = ReloadDataOperation(controller: controler)
        reloadDataOperation.addDependency(parseDataOperation)
        
        reloadDataOperation.completionBlock = {
            DispatchQueue.main.async { [weak self] in
                self?.progressHud.dismiss(animated: true)
            }
        }
        
        OperationQueue.main.addOperation(reloadDataOperation)
    }
}
