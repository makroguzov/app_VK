//
//  UserGroupsGetDataOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 15.10.2020.
//

import Foundation
import Alamofire

class GetEventsOP: AsyncOperation {
    
    private var requests: [SectionID: DataRequest] = [:]
    
    
    var friends = JSON()
    var events = JSON()
    
    
    init(params: [Int: VKRequestParametrs]) {
        for (section, param) in params {
            requests[section] = session.request(param.getBaseUrl() + param.getPath(),
                                      method: .get,
                                      parameters: param.getParams()
            )
        }
    }
    
    override func main() {
        for (section, request) in requests {
            group.enter()
            getJSON(for: section, request)
        }
        
        group.notify(queue: .global(qos: .userInitiated)) { [weak self] in
            self?.state = .finished
        }
    }
    
    private func getJSON(for section: Int, _ request: DataRequest) {
        request.responseJSON(queue: .global(qos: .userInitiated)) { [weak self] response in
            self?.group.leave()
            
            switch response.result {
            case let .success(json):
                guard let response = (json as? JSON)?["response"] as? JSON else {
                    print("Problems with losding data in class: GetDataOperation, at function: \(#function). Response is not exist.")
                    return
                }
                
                self?.jsons[section] = response
            case let .failure(error):
                print("Problems with losding data in class: GetDataOperation, at function: \(#function). Error: \(error.localizedDescription)")
            }
        }
    }

}
