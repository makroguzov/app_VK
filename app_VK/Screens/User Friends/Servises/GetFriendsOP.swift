//
//  GetFriendsOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 16.10.2020.
//

import Foundation
import Alamofire

class GetFriendsOP: AsyncOperation {
    
    var friends = [UserFriendCellModel]()
    var impFriends =  [UserFriendCellModel]()
    var birthdays = [UserFriendCellModel]()
    
    private var viewModel: UserFriendsViewModel
    
    init(viewModel: UserFriendsViewModel) {
        self.viewModel = viewModel
    }
        
    override func main() {
        group.enter()
        let frParams = getParamsForFr()
        AlamofireSession.shared.getResponse(with: frParams) { [weak self] (response) in
            guard let self = self else {
                return
            }
            
            self.friends = self.parse(response)
            self.group.leave()
        }
        
        
        group.enter()
        let impFrParams = getParamsForImpFr()
        AlamofireSession.shared.getResponse(with: impFrParams) { [weak self] (response) in
            guard let self = self else {
                return
            }
            
            self.impFriends = self.parse(response)
            self.group.leave()
        }
        
        
        group.notify(queue: .global(qos: .userInitiated)) { [weak self] in
            guard let self = self else {
                return
            }
            self.birthdays = self.getBirthdays()
            self.state = .finished
            
//            #if DEBUG
//            print("Load 'birthdays' from GetFriendsOP: ", self.birthdays)
//            print("Load 'friends' from GetFriendsOP: ", self.friends)
//            print("Load 'impFriends' from GetFriendsOP: ", self.impFriends)
//            #endif
        }
    }
    
    private func getParamsForImpFr() -> VKRequestParametrs {
        return VKRequestParametrs(path: .friends,
                                  params: [
                                    "order": "hints",
                                    "count": 5,
                                    "fields": "photo_100,bdate"
                                  ]
        )
    }

    private func getParamsForFr() -> VKRequestParametrs {
        return VKRequestParametrs(path: .friends,
                                  params: [
                                    "order": "hints",
                                    "offset": 5,
                                    //"count": 20,
                                    "fields": "photo_100,bdate"
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
    
    private func getBirthdays() -> [UserFriendCellModel] {
        let allFriends = impFriends + friends
        birthdays = allFriends.filter {
            guard let bDate = $0.bDate else {
                return false
            }
            
            let components = Calendar.current.dateComponents([.day], from: bDate, to: Date())
            let days = components.day ?? 0
            
            let validDaysInterval = 7
            
            if days < validDaysInterval {
                return true
            } else {
                return false
            }
        }
        
        return birthdays
    }
    
    private func printError(at function: String, error: String) {
        print("Error in class: GetFriendsOP at function: \(function). \(error)")
    }
}
