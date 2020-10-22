//
//  News.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct News: Codable {
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
        case newOffset = "new_offset"
    }
    
    var items: [Post] = []
    var profiles: [User] = []
    var groups: [Group] = []
    
    var nextFrom: Int
    var newOffset: Int
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        do {
            items = try container.decode([Post].self, forKey: .items)
        } catch DecodingError.dataCorrupted(let context) {
            print("\(context.debugDescription) with keys: \(context.codingPath)")
        }
        
        
//        if let items = try? container.decode([Post].self, forKey: .items) {
//            self.items = items
//        } else {
//            print("Error in class: News at function:\(#function). Problems with decode items.")
//        }

        if let profiles = try? container.decode([User].self, forKey: .profiles) {
            self.profiles = profiles
        } else {
            print("Error in class: News at function:\(#function). Problems with decode profiles.")
        }

        if let groups = try? container.decode([Group].self, forKey: .groups) {
            self.groups = groups
        } else {
            print("Error in class: News at function:\(#function). Problems with decode groups.")
        }
        
        newOffset = try container.decode(Int.self, forKey: .newOffset)
        nextFrom = try container.decode(Int.self, forKey: .nextFrom)
    }
}
