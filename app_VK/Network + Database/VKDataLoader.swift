//
//  VKDataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation
import Alamofire

class VKDataLoader {
    
    static var shared = VKDataLoader()
    private init() {}
    
    
    private let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()

    
    func loadDataAsJSON(with params: VKRequestParametrs, complition: @escaping ([String: Any]) -> Void) {
        session.request(params.getBaseUrl() + params.getPath(), method: .get, parameters: params.getParams()).responseJSON { response in
         
            switch response.result {
            case let .success(json):
                guard let response = (json as? [String: Any])?["response"] as? [String: Any] else {
                    print("Error with loading data. Response is not exist.")
                    return
                }
                
                complition(response)
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
