//
//  Video.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

struct Video: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, duration, image, date, views, comments, width, height, player
        case ownerId = "owner_id"
    }

    struct Image: Codable {
        
        let height: Int
        let width: Int
        let url: String
        
    }

    let id: Int
    let ownerId: Int
    let title: String = ""
    let description: String = ""
    let duration: Int
    let width: Int
    let height: Int
    
    let image: Image
    let date: String
    
    let views: Int
    let comments: Int
    
    let player: String
}
