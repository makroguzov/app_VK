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
    var groups = [Group]()
    var events = [Group]()
    
    override func main() {
        guard let data = dependencies.first as? ParseEventsOP else {
            return
        }
        
        groups = data.groups
        events = data.events
        
        let profilesIds = data.profiles
        requests = getRequests(for: profilesIds)

        getUsers()
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
        return VKRequestParametrs(path: .users,
                                  params: [
                                    "user_ids": userId,
                                    "fields": "photo_100"
                                  ]
        )
    }

    private func getUsers() {
        for request in requests {
            request.responseJSON { [weak self] response in
                switch response.result {
                case let .success(json):
                    
                    guard let response = (json as? JSON)?["response"] as? [JSON] else {
                        self?.printError(in: #function, error: "Response is not exist.")
                        return
                    }
                    
                    guard let userJSON = response.first,
                          let data = try? JSONSerialization.data(withJSONObject: userJSON, options: .withoutEscapingSlashes) else {
                        self?.printError(in: #function, error: "Can't transform User JSON to data.")
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    guard let user = try? decoder.decode(User.self, from: data) else {
                        self?.printError(in: #function, error: "Problems with decode Profiles.")
                        return
                    }
                    
                    self?.profiles.append(user)
                    
                case let .failure(error):
                    print(error.localizedDescription)
                }
                
                self?.state = .finished
            }
        }
    }
    
    override func cancel() {
        super.cancel()
        
        for request in requests {
            request.cancel()
        }
    }
    
    private func printError(in function: String, error: String) {
        print("Problems with losding data in class: GetProfilesOPGetProfilesOP, at function: \(function). \(error)")
    }
}
