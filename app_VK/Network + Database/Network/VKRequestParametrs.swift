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
        case friends = "friends.get"
        case newsfeed = "newsfeed.get"
        case invites = "groups.getInvites"
        case groups = "groups.get"
        case users = "users.get"
        case requestsForFriends = "friends.getRequests"
        
        var pathValue: String {
            return "/method/" + self.rawValue
        }
    }

    private let baseUrl: String = "https://api.vk.com"
    private let versionAPI = "5.92"
    private let defoltParms: Parameters
    private var path: LoadDataType
    
    var params: Parameters
    var url: String {
        return baseUrl + path.pathValue
    }
    
    init(path: LoadDataType, params: Parameters) {
        self.path = path
        
        self.defoltParms = [
        "access_token": Session.shared.token,
        "v": versionAPI
        ]
        
        self.params = defoltParms.merging(params) { (defoltParms, _) in defoltParms }
    }
        
}

