//
//  Comment.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

struct Comment: Codable {
    
    enum CodingKeys: String, CodingKey {
        case count
        case canComment = "can_post"
    }
    
    var count: Int = 0
    var canComment: Int = 0
        
    init(count: Int, canComment: Int) {
        self.count = count
        self.canComment = canComment
    }
}

extension Comment {
    static var empty: Comment {
        return Comment(count: 0,
                       canComment: 0
        )
    }
}
