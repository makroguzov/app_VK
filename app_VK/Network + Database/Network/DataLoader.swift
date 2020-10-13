//
//  DataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 12.10.2020.
//

import Foundation

class DataLaoder {
    
    let networkManager: NetworkManager
    
    init(parser: Parser, controler: DataReloadedController) {
        networkManager = NetworkManager(parser: parser, controler: controler)
    }
    
}
