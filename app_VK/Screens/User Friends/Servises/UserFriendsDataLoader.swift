//
//  UserFriendsDataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 16.10.2020.
//

import UIKit
import JGProgressHUD

class UserFriendsDataLoader {
    
    enum Data {
        case requestsForFriends
        case friends
    }
    
    private var viewModel: UserFriendsViewModel!
    private var group = DispatchGroup()
    
    private let hud = JGProgressHUD(style: .dark)
    
    private var friends = [UserFriendCellModel]()
    private var impFriends =  [UserFriendCellModel]()
    private var birthdays = [UserFriendCellModel]()
    private var requestsForFr = [UserFriendCellModel]()
    
    init() {}
    convenience init(_ viewModel: UserFriendsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    func loadData(for data: [Data]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.hud.show(in: self.viewModel.controller.view, animated: true)
        }
        
        let queue = OperationQueue()
        
        for data in data {
            group.enter()
            
            switch data {
            case .requestsForFriends:
                let getReqForFrOP = GetRequestsForFrOP(viewModel: viewModel)
                getReqForFrOP.completionBlock = { [weak self] in
                    self?.requestsForFr = getReqForFrOP.requestsForFr
                    
                    self?.group.leave()
                }
                
                queue.addOperation(getReqForFrOP)
            case .friends:
                let getFriendsOP = GetFriendsOP(viewModel: viewModel)
                getFriendsOP.completionBlock = { [weak self] in
                    self?.friends = getFriendsOP.friends
                    self?.impFriends = getFriendsOP.impFriends
                    self?.birthdays = getFriendsOP.birthdays
                    
                    self?.group.leave()
                }
                
                queue.addOperation(getFriendsOP)
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
               
            typealias Section = UserFriendsViewModel.Sections
            var models = [Section]()
            
            if !self.requestsForFr.isEmpty {
                models.append(.requestsForFriends([.forRequests(reqquests: self.requestsForFr)]))
            }
            
            if !self.impFriends.isEmpty {
                models.append(.mostImportant(self.impFriends))
            }

            if !self.birthdays.isEmpty {
                models.append(.birthdays(self.birthdays))
            }

            if !self.friends.isEmpty {
                models.append(.friends(self.friends))
            }
        
            self.viewModel.insert(models: models)
            self.hud.dismiss(animated: true)
        }
    }
}


