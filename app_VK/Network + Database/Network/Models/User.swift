//
//  User.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import Foundation

class User: Codable {
    
    enum CodingCeys: String, CodingKey {
        case id, deactivated, about, activities, bdate, city
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
    
    let id: Int
    
    let firstName: String
    let lastName: String
    
    let deactivated: String?
    
    let isClosed: Bool?
    let canAccessClosed: Bool?
    
    let about: String?
    let activities: String?
    let bdate: String? //Возвращается в формате D.M.YYYY или D.M (если год рождения скрыт)
    let city: City?
    
    let photo50: String?
    let photo100: String?
    let photo200: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingCeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        
        deactivated = try? container.decode(String.self, forKey: .deactivated)
        
        isClosed = try? container.decode(Bool.self, forKey: .isClosed)
        canAccessClosed = try? container.decode(Bool.self, forKey: .canAccessClosed)
        
        about = try? container.decode(String.self, forKey: .about)
        activities = try? container.decode(String.self, forKey: .activities)
        bdate = try? container.decode(String.self, forKey: .bdate)
        city = try? container.decode(City.self, forKey: .city)
        
        photo50 = try? container.decode(String.self, forKey: .photo50)
        photo100 = try? container.decode(String.self, forKey: .photo100)
        photo200 = try? container.decode(String.self, forKey: .photo200)
    }
}
