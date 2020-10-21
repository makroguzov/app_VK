//
//  Photo.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct Photo: Codable {

    enum CodingKeys: String, CodingKey {
        case id, text, date, sizes
        case albumId = "album_id"
        case ownerId = "ownerId"
    }
    
    struct Size: Codable {
        
        var url: String
        var width: Int
        var height: Int
        
    }
    
    var id: Int
    var albumId: Int
    var ownerId: Int
    
    var text: String
    var date: String
    
    var sizes: [Size]
}
