//
//  GetEventsOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 15.10.2020.
//

import Foundation
import Alamofire

class GetEventsOP: AsyncOperation {
    
    private var request: DataRequest
    
    var events: [JSON]?
    var groups: [JSON]?
    var profiles: [JSON]?
    
    init(param: VKRequestParametrs) {
        request = GetEventsOP.session.request(param.url,
                                  method: .get,
                                  parameters: param.params
        )
    }
    
    override func main() {
        getJSON(with: request)
    }
    
    private func getJSON(with request: DataRequest) {
        request.responseJSON(queue: .global(qos: .userInitiated)) { [weak self] response in
            
            switch response.result {
            case let .success(json):
                guard let response = (json as? JSON)?["response"] as? JSON else {
                    self?.printError(in: #function, error: "Response is not exist.")
                    return
                }
                
                guard let events = response["items"] as? [JSON] else {
                    self?.printError(in: #function, error: "Items is not exist.")
                    return
                }
                
                guard let groups = response["groups"] as? [JSON] else {
                    self?.printError(in: #function, error: "Groups is not exist.")
                    return
                }
                
                guard let profiles = response["profiles"] as? [JSON] else {
                    self?.printError(in: #function, error: "Profiles is not exist.")
                    return
                }
                
                            
                self?.events = events
                self?.groups = groups
                self?.profiles = profiles
                                
//                #if DEBUG
//                print("Load Events by GetEventsOP: ", self?.events ?? "nil")
//                print("Load Profiles by GetEventsOP: ", self?.profiles ?? "nil")
//                print("Load Groups by GetEventsOP: ", self?.groups ?? "nil")
//                #endif

            case let .failure(error):
                self?.printError(in: #function, error: error.localizedDescription)
            }
            
            self?.state = .finished
        }
    }

    private func printError(in function: String, error: String) {
        print("Problems with losding data in class: GetEventsOP, at function: \(function). \(error)")
    }

}
