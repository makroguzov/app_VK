//
//  Link.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

struct Link: Codable {
    
    let url: String
    let title: String
    let caption: String?
    let description: String
    let photo: Photo?
    
}
