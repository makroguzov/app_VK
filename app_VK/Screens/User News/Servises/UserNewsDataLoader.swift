//
//  UserNewsDataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation
import JGProgressHUD

class UserNewsDataLoader {
    
    private var hud = JGProgressHUD(style: .dark)
    private var viewModel: UserNewsViewModel
    
    private var nextFrom: String = ""
    
    init(viewModel: UserNewsViewModel) {
        self.viewModel = viewModel
    }
    
    func loadData() {
        hud.show(in: viewModel.controller.view)
        
        
        let queue = OperationQueue()
        
        let getNewsOP = GetNewsOP(startFrom: nextFrom)
        getNewsOP.completionBlock = { [weak self] in
            guard let self = self else {
                return
            }
            
            guard let nextFrom = getNewsOP.news?.nextFrom else {
                return
            }
            
            self.nextFrom = nextFrom
        }
        queue.addOperation(getNewsOP)
        
        
        let parseNewsOP = ParseNewsOP()
        parseNewsOP.addDependency(getNewsOP)
        parseNewsOP.completionBlock = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.viewModel.insert(models: parseNewsOP.models)
                self.hud.dismiss(animated: true)
            }
        }
        queue.addOperation(parseNewsOP)
    }
    private func printError(at function: String, error: String) {
        print("Error in class: UserNewsDataLoader at function: \(function). \(error)")
    }
}
