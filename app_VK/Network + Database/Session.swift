//
//  Session.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation

class Session {
    
    var token = ""
    var userId = ""
    
    static let shared = Session()
    private init() { }

}
