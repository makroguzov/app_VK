//
//  SetUpGroupsModelOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 15.10.2020.
//

import Foundation

class SetUpGroupsModelOP: Operation {
    
    private let viewModel: UserGroupsTableViewModel?
    
    init(viewModel: UserGroupsTableViewModel?) {
        self.viewModel = viewModel
    }
    
    override func main() {
        for dependence in dependencies {
            if let data = dependence as? ParseGroupsOP {
                
                let models: [UserGroupCellModel] = data.groups.map { .forGroup($0) }
                viewModel?.insert(models: [1: models])
            }
            
            if let data = dependence as? GetProfilesOP {
                let events = data.events
                
                let profiles = data.profiles
                let groups = data.groups
                
                var models = [GroupsInvitationCellModel]()
                
                for event in events {
                    guard let invitedBy = event.invitedBy else {
                        return
                    }
                    
                    let creator: Creator
                    
                    if invitedBy < 0 {
                        guard let group = groups.filter({ $0.id == abs(invitedBy) }).first else {
                            return
                        }
                        
                        creator = Creator(group: group)
                    } else {
                        guard let profile = profiles.filter({ $0.id == invitedBy }).first else {
                            return
                        }
                        
                        creator = Creator(profile: profile)
                    }
                    
                    models.append(.forEvent(event: event, invitor: creator))
                }
                
                print(models)
                viewModel?.insert(models: [0: models])
            }
        }
    }
    
}
