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
    
    var events = [JSON]()
    var groups = [JSON]()
    var profiles = [JSON]()
    
    init(param: VKRequestParametrs) {
        request = GetEventsOP.session.request(param.getBaseUrl() + param.getPath(),
                                  method: .get,
                                  parameters: param.getParams()
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
                
            case let .failure(error):
                self?.printError(in: #function, error: error.localizedDescription)
            }
        }
    }

    
    private func printError(in function: String, error: String) {
        print("Problems with losding data in class: GetDataOperation, at function: \(function). \(error)")
    }
}
