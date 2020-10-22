//
//  GetRequestsForFrOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 16.10.2020.
//

import Foundation

class GetRequestsForFrOP: AsyncOperation {
    
    private var viewModel: UserFriendsViewModel
    
    var requestsForFr = [UserFriendCellModel]()
    
    init(viewModel: UserFriendsViewModel) {
        self.viewModel = viewModel
    }
        
    override func main() {
        let params = getParamsForReqForFr()
        AlamofireSession.shared.getResponse(with: params) { [weak self] (response) in
            guard let self = self else {
                return
            }
            
            self.requestsForFr = self.parse(response)
            self.state = .finished
            
//            #if DEBUG
//            print("Load requestsForFr from GetRequestsForFrOP: ", self.requestsForFr)
//            #endif
        }
    }
    
    private func getParamsForReqForFr() -> VKRequestParametrs {
        return VKRequestParametrs(path: .requestsForFriends,
                                  params: [
                                    "out": 0,
                                    "count": 3,
                                    "fields": "photo_100",
                                    "extended": 1
                                  ]
        )
    }

    private func parse(_ json: JSON) -> [UserFriendCellModel] {
        guard let friendsJSON = json["items"] as? [JSON] else {
            printError(at: #function, error: "Can't find 'items'.")
            return []
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: friendsJSON, options: .withoutEscapingSlashes) else {
            printError(at: #function, error: "Problems with transform to data.")
            return []
        }
        
        let decoder = JSONDecoder()
        guard let friends = try? decoder.decode([User].self, from: data)  else {
            printError(at: #function, error: "Prodlems with Decode data.")
            return []
        }
        
        let models: [UserFriendCellModel] = friends.map({ .forFriend($0) })
        return models
    }
    
    private func printError(at function: String, error: String) {
        print("Error in class: GetRequestsForFrOP at function: \(function). \(error)")
    }
}
