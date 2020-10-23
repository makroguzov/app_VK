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
    
    var nextFrom: String = ""
    var newOffset: Int = 0
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let newOffset = try? container.decode(Int.self, forKey: .newOffset) {
            self.newOffset = newOffset
        }

        do {
            nextFrom = try container.decode(String.self, forKey: .nextFrom)
            
            items = try container.decode([Post].self, forKey: .items)
            profiles = try container.decode([User].self, forKey: .profiles)
            groups = try container.decode([Group].self, forKey: .groups)
        } catch DecodingError.dataCorrupted(let context) {
            print("\(context.debugDescription) with keys: \(context.codingPath).")
        } catch let DecodingError.keyNotFound(key, context) {
            print("\(context.debugDescription) with key: \(key).")
        } catch let DecodingError.valueNotFound(type, context) {
            print("\(context.debugDescription) for type: \(type).")
        } catch let DecodingError.typeMismatch(type, context){
            print("\(context.debugDescription) for type: \(type).")
        }
    }
}
