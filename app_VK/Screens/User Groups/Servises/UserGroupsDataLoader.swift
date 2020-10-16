//
//  UserGroupsDataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit
import JGProgressHUD

class UserGroupsDataLoader {
        
    enum Section {
        case friend, invitations
    }
    
    private var viewModel: UserGroupsTableViewModel?
    private var controller: UIViewController?
    
    private let hud = JGProgressHUD(style: .dark)
    
    private let queue = OperationQueue()
    
    init() {}
    
    convenience init(viewModel: UserGroupsTableViewModel, controller: UIViewController) {
        self.init()
        
        self.controller = controller
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
        
        if let controller = controller {
            
            DispatchQueue.main.async { [weak self] in
                self?.hud.show(in: controller.view, animated: true)
            }
        }
        
        
        let eventsParams = getInvitationsParametrs()
        let getEventsOP = GetEventsOP(param: eventsParams)
        queue.addOperation(getEventsOP)
        
        let parseEventsOP = ParseEventsOP()
        parseEventsOP.addDependency(getEventsOP)
        queue.addOperation(parseEventsOP)
        
        let getProfiles = GetProfilesOP()
        getProfiles.addDependency(parseEventsOP)
        queue.addOperation(getProfiles)

        
        
        let groupsParams = getGroupsParametrs()
        let getGroupsOP = GetGroupsOP(param: groupsParams)
        queue.addOperation(getGroupsOP)
        
        let parseGroupsOP = ParseGroupsOP()
        parseGroupsOP.addDependency(getGroupsOP)
        queue.addOperation(parseGroupsOP)
        
        
        
        let setUpViewModelOP = SetUpGroupsModelOP(viewModel: viewModel)
        setUpViewModelOP.addDependency(parseGroupsOP)
        setUpViewModelOP.addDependency(getProfiles)
        
        setUpViewModelOP.completionBlock = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.hud.dismiss(animated: true)
            }
        }

        OperationQueue.main.addOperation(setUpViewModelOP)
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
                                            "extended": 1
                                        ]
        )
        return request
    }
}
