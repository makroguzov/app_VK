//
//  Creator.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

struct Creator {
    
    let name: String
    let image: String
    
    init(group: Group) {
        name = group.name
        image = group.photo100
    }
    
    init(profile: User) {
        name = "\(profile.firstName) \(profile.lastName)"
        image = profile.photo100 ?? ""
    }
    
}
