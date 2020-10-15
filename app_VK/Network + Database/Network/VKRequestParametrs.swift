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
    }

    private let baseUrl: String = "https://api.vk.com"
    private var path: LoadDataType
    private var params: Parameters
    
    private let defoltParms: Parameters = [
        "access_token": Session.shared.token,
        "v": 5.21
    ]
    
    init(path: LoadDataType, params: Parameters) {
        self.path = path
        self.params = defoltParms.merging(params) { (defoltParms, _) in defoltParms }
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

