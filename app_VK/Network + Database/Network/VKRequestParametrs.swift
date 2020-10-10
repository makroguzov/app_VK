//
//  VKRequestParametrs.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation

import Foundation
import Alamofire

class VKRequestParametrs {

    enum LoadDataType: String {
        case friends = "/method/friends.get"
        case newsfeed = "/method/newsfeed.get"
        case invites = "/method/groups.getInvites"
        case groups = "/method/groups.get"
        case none
    }

    private let baseUrl: String = "https://api.vk.com"
    private var path: LoadDataType
    private var params: Parameters
    
    init() {
        path = .none
        params = [
            "access_token": Session.shared.token,
            "v": 5.21
        ]
    }
    
    func set(path: LoadDataType) {
        self.path = path
    }
    
    func set(params: Parameters) {
        params.forEach { (key, value) in
            self.params[key] = value
        }
    }
    
    func getBaseUrl() -> String {
        return baseUrl
    }

    func getPath() -> String {
        return path.rawValue
    }
        
    func getParams() -> Parameters {
        return params
    }
}

