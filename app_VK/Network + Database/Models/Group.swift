//
//  Group.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import Foundation

class Group: Codable {
    
    enum Errors {
        case DecodeError(String)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, deactivated, type
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case isAdmin = "is_admin"
        case adminLevel = "admin_level"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case invitedBy = "invited_by"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
    
    let id: Int
    let type: String
    
    let name: String
    let screenName: String
    
    let deactivated: String?
    let invitedBy: Int?
    let adminLevel: Int?
    
    let isClosed: Int
    let isAdmin: Int
    let isMember: Int
    let isAdvertiser: Int
    
    let photo50: String
    let photo100: String
    let photo200: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
  
        name = try container.decode(String.self, forKey: .name)
        screenName = try container.decode(String.self, forKey: .screenName)
                                          
        deactivated = try? container.decode(String.self, forKey: .deactivated)
        invitedBy = try? container.decode(Int.self, forKey: .invitedBy)
        adminLevel = try? container.decode(Int.self, forKey: .adminLevel)

        isClosed = try container.decode(Int.self, forKey: .isClosed)
        isAdmin = try container.decode(Int.self, forKey: .isAdmin)
        isMember = try container.decode(Int.self, forKey: .isMember)
        isAdvertiser = try container.decode(Int.self, forKey: .isAdvertiser)

        photo50 = try container.decode(String.self, forKey: .photo50)
        photo100 = try container.decode(String.self, forKey: .photo100)
        photo200 = try container.decode(String.self, forKey: .photo200)
    }
}
