//
//  GetGroupsOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 15.10.2020.
//

import Foundation
import Alamofire

class GetGroupsOP: AsyncOperation {
    
    private var request: DataRequest
    
    var groups = [JSON]()
    
    init(param: VKRequestParametrs) {
        request = GetGroupsOP.session.request(param.getBaseUrl() + param.getPath(),
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
                
                guard let groups = response["items"] as? [JSON] else {
                    self?.printError(in: #function, error: "Items is not exist.")
                    return
                }
                            
                self?.groups = groups
            case let .failure(error):
                self?.printError(in: #function, error: error.localizedDescription)
            }
        }
    }

    
    private func printError(in function: String, error: String) {
        print("Problems with losding data in class: GetDataOperation, at function: \(function). \(error)")
    }

    
    override func cancel() {
        super.cancel()
        request.cancel()
    }
}
