//
//  ALamofireSession.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 16.10.2020.
//

import Alamofire

class AlamofireSession {
    
    static let shared = AlamofireSession()
    private init() {}
    
    let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    let group = DispatchGroup()
    
    func getResponse(with params: VKRequestParametrs, complition: @escaping (_ response: JSON) -> Void) {
        session.request(params.url,
                        method: .get,
                        parameters: params.params).responseJSON(queue: .global(qos: .userInitiated)) { [weak self] response in
                            
                            switch response.result {
                            case let .success(json):
                                guard let response = (json as? JSON)?["response"] as? JSON else {
                                    self?.printError(in: #function, error: "Response is not exist.")
                                    return
                                }
                                complition(response)
                            case let .failure(error):
                                print(error.localizedDescription)
                            }
                        }
    }
    
    private func printError(in function: String, error: String) {
        print("Problems with losding data in class: ALamofireSession, at function: \(function). \(error)")
    }
}
