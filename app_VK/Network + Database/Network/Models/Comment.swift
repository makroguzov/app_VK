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
        case canPost = "can_post"
    }
    
    var count: Int = 0
    var canPost: Int = 0
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            count = try container.decode(Int.self, forKey: .count)
            canPost = try container.decode(Int.self, forKey: .canPost)
        } catch {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [],
                                      debugDescription: "Problems with decode in \(#file)")
            )
        }
    }
    
    init(count: Int, canPost: Int) {
        self.count = count
        self.canPost = canPost
    }
}

extension Comment {
    static var empty: Comment {
        return Comment(count: 0,
                       canPost: 0
        )
    }
}
