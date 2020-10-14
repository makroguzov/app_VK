//
//  GetDataOperation.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    
    private let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    private var group = DispatchGroup()
    
    private var requests: [Int: DataRequest] = [:]
    var jsons = [Int: [String: Any]]()
    
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
                guard let response = (json as? [String: Any])?["response"] as? [String: Any] else {
                    print("Problems with losding data in class: GetDataOperation, at function: \(#function). Response is not exist.")
                    return
                }
                
                self?.jsons[section] = response
            case let .failure(error):
                print("Problems with losding data in class: GetDataOperation, at function: \(#function). Error: \(error.localizedDescription)")
            }
        }
    }
    
    override func cancel() {
        for request in requests.values {
            request.cancel()
            super.cancel()
        }
    }
}
