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
    
    private var request: DataRequest
    var json: [String: Any]?
    
    init(params: VKRequestParametrs) {
        request = session.request(params.getBaseUrl() + params.getPath(),
                                  method: .get,
                                  parameters: params.getParams())
    }
    
    override func main() {
        request.responseJSON { [weak self] response in
            
            switch response.result {
            case let .success(json):
                guard let response = (json as? [String: Any])?["response"] as? [String: Any] else {
                    print("Problems with losding data in class: GetDataOperation, at function: \(#function). Response is not exist.")
                    return
                }
                self?.json = response
            
            case let .failure(error):
                print("Problems with losding data in class: GetDataOperation, at function: \(#function). Error: \(error.localizedDescription)")
            }
        }
    }
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
}
