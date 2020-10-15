//
//  UserGroupsDataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation

class UserGroupsDataLoader {
        
    enum Section {
        case friend, invitations
    }
    
    private var viewModel: UserGroupsTableViewModel?
    private let queue = OperationQueue()
    
    init() {}
    
    convenience init(viewModel: UserGroupsTableViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
        
    func load(dataFor sections: [Section]) {
        for section in sections {
            switch section {
            case .friend:
                getFriends()
            case .invitations:
                getEvents()
            }
        }
    }
    
    private func getEvents() {
        let params = getGroupsParametrs()
        
        let getEventsOP = GetEventsOP(param: params)
        queue.addOperation(getEventsOP)
        
        let parseEventsOP = ParseEventsOP()
        queue.addOperation(parseEventsOP)
        parseEventsOP.addDependency(getEventsOP)
        
        let getProfiles = GetProfilesOP()
        queue.addOperation(getProfiles)
        getProfiles.addDependency(parseEventsOP)
        
        //let setUpViewModel = 
    }
    
    private func getFriends() {
        
    }
    
    private func getGroupsParametrs() -> VKRequestParametrs  {
        let request = VKRequestParametrs(path: .groups,
                                         params: [
                                            "user_id": Session.shared.userId,
                                            "extended": 1
                                        ]
        )

        return request
    }

    private func getInvitationsParametrs() -> VKRequestParametrs {
        let request = VKRequestParametrs(path: .invites,
                                         params: [
                                            "user_id": Session.shared.userId,
                                        ]
        )
        return request
    }
}
