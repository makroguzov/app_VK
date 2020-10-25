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
    
    var count: Int = 0
    var userLikes: Int = 0
    var canLike: Int = 0
    var canPublish: Int
    
    
    init(count: Int, userLikes: Int, canLike: Int, canPublish: Int) {
        self.count = count
        self.userLikes = userLikes
        self.canLike = canLike
        self.canPublish = canPublish
    }
}

extension Like {
    static var empty: Like {
        return Like(count: 0,
                    userLikes: 0,
                    canLike: 0,
                    canPublish: 0
        )
    }
}
