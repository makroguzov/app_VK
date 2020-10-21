//
//  Like.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct Like: Codable {
   
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
    
    var count: Int
    var userLikes: Int
    var canLike: Int
    var canPublish: Int
    
}
