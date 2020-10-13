//
//  UserGroupsDataLoader.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation

class UserGroupsDataLoader: DataLaoder {
    
    enum Section {
        case friend, invitations
    }
        
    func load(dataFor sections: [Section]) {
        var params = [VKRequestParametrs]()
        
        for section in sections {
            switch section {
            case .friend:
                params.append(self.getGroupsParametrs())
            case .invitations:
                params.append(self.getInvitationsParametrs())
            }
            
            networkManager.loadData(with: params)
        }
    }
    
    private func getGroupsParametrs() -> VKRequestParametrs  {
        let request = VKRequestParametrs()
        request.set(path: .groups)

        let params: [String: Any] = [
            "user_id": Session.shared.userId,
            "extended": 1
        ]
        request.set(params: params)
        return request
    }

    private func getInvitationsParametrs() -> VKRequestParametrs {
        let request = VKRequestParametrs()
        request.set(path: .invites)
        
        let params: [String: Any] = [
            "user_id": Session.shared.userId,
            "extended": 1
        ]
        request.set(params: params)
        return request
    }
}
