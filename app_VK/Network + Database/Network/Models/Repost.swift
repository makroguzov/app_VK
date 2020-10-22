//
//  Repost.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

struct Repost: Codable {
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
    
    var count: Int
    var userReposted: Int
    
}

extension Repost {
    static var empty: Repost {
        return Repost(count: 0,
                      userReposted: 0
        )
    }
}
