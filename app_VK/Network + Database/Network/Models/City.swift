//
//  City.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import Foundation

class City: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, title
    }
    
    let id: Int
    let title: String
    
}
