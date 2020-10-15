//
//  GetProfilesOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 15.10.2020.
//

import Foundation
import Alamofire

class GetProfilesOP: AsyncOperation {
    
    private var requests = [DataRequest]()
    var profiles = [User]()
    
    override func main() {
        guard let events = dependencies.first as? ParseEventsOP else {
            return
        }
        
        let profilesIds = events.profiles
        requests = getRequests(for: profilesIds)
    }
    
    private func getRequests(for profilesIds: [Int]) -> [DataRequest] {
        var requests = [DataRequest]()
        
        for profilesId in profilesIds {
            let params = getParams(for: profilesId)
            
            let request = GetProfilesOP.session.request(params.getBaseUrl() + params.getPath(),
                                          method: .get,
                                          parameters: params.getParams()
            )
            requests.append(request)
        }
        
        return requests
    }
    
    
    private func getParams(for userId: Int) -> VKRequestParametrs {
        return VKRequestParametrs(path: .friends,
                                  params: Parameters
        )
    }
}
