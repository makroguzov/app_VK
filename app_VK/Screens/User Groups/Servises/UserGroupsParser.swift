//
//  UserGroupsParser.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit
import SDWebImage

class UserGroupsParser {
    
    enum Errors: Error {
        case ParsingDataError(String)
        case TransformToDataError(String)
        case DecodeError(String)
        case CreateSectionError(Int)
    }
    
    private let decoder = JSONDecoder()
    private let group = DispatchGroup()

    
    func parseData(with jsons: [Int: [String : Any]]) -> [SectionID: Any] {
        guard !jsons.isEmpty else {
            return [:]
        }
        
        var sections = [SectionID: Any]()

        for (sectionId, json) in jsons {
            do {
                let section = try parseJSON(json, for: sectionId)
                sections[sectionId] = section
            } catch let Errors.CreateSectionError(section){
                print("Problems with parsing in class: UserGroupsParser at function: \(#function). Can't create section - '\(section)'.")
            } catch {
                print("Unknown error.")
            }
        }
        return sections
    }
    
    private func parseJSON(_ json: JSON, for section: SectionID) throws -> Any {
        do {
            if section == 0 {
                let invitationsSection = try getInvitationsSection(with: json)
                return invitationsSection
            } else {
                let groupsSction = try getGroupsSection(with: json)
                return groupsSction
            }
            
        } catch let Errors.ParsingDataError(item) {
            print("Problems with parsing in class: UserGroupsParser at function: \(#function). Can't find '\(item)'.")
            throw Errors.CreateSectionError(section)
        } catch let Errors.TransformToDataError(item){
            print("Problems with parsing in class: UserGroupsParser at function: \(#function). Can't transform '\(item)' to data.")
            throw Errors.CreateSectionError(section)
        } catch let Errors.DecodeError(item){
            print("Problems with parsing in class: UserGroupsParser at function: \(#function). Problems with Decode \(item)")
            throw Errors.CreateSectionError(section)
        } catch {
            print("Unknown error.")
            throw Errors.CreateSectionError(section)
        }
    }
    
    private func getGroupsSection(with json: [String: Any]) throws -> [UserGroupCellModel] {
        let groups: [Group]
        
        do {
            groups = try parseItems(json: json)
        } catch let error {
            throw error
        }
 
        var groupsModels = [UserGroupCellModel]()
        for group in groups {
            groupsModels.append(.forGroup(group))
        }
        
        return groupsModels
    }

    private func getInvitationsSection(with json: [String: Any]) throws -> [GroupsInvitationCellModel] {
        
        let items: [Group]
        let groups: [Group]
        let profiles: [User]
        
        do {
            items = try parseItems(json: json)
            groups = try parseGroups(json: json)
            profiles = try parseProfiles(json: json)
        } catch let error {
            throw error
        }
        
        var models = [GroupsInvitationCellModel]()
        
        for event in items {
            guard let invitorId = event.invitedBy else {
                continue
            }
            
//            if invitorId < 0 {
//                guard let invitor = groups.filter { $0.id == -invitorId }.first else {
//                    continue
//                }
//                
//                models.append(.forEvent(event: event, invitor: invitor))
//            } else {
//                
//                guard let invitor = profiles.filter { $0.id == invitorId }.first else {
//                    <#statements#>
//                }
//                  
//            }
//            
        }
        
        return models
    }

}

//MARK: Parse items, groups, profiles

extension UserGroupsParser {
    
    private func parseItems(json: [String: Any]) throws -> [Group] {
        if let items = json["items"] as? [Any] {
            guard let data = try? JSONSerialization.data(withJSONObject: items, options: .withoutEscapingSlashes) else {
                throw Errors.TransformToDataError("items")
            }
            
            guard let items = try? decoder.decode([Group].self, from: data) else {
                throw Errors.DecodeError("[Group]")
            }
            
            return items
        } else {
            throw Errors.ParsingDataError("items")
        }
    }
    
    private func parseGroups(json: [String: Any]) throws -> [Group] {
        if let groups = json["groups"] as? [Any] {
            guard let data = try? JSONSerialization.data(withJSONObject: groups, options: .withoutEscapingSlashes) else {
                throw Errors.TransformToDataError("groups")
            }
            
            guard let groups = try? decoder.decode([Group].self, from: data) else {
                throw Errors.DecodeError("[Group]")
            }
            
            return groups
        } else {
            throw Errors.ParsingDataError("groups")
        }
    }
    
    private func parseProfiles(json: [String: Any]) throws -> [User] {
        if let profiles = json["profiles"] as? [Any] {
            guard let data = try? JSONSerialization.data(withJSONObject: profiles, options: .withoutEscapingSlashes) else {
                throw Errors.TransformToDataError("profiles")
            }
            
            guard let profiles = try? decoder.decode([User].self, from: data) else {
                throw Errors.DecodeError("[User]")
            }
            
            return profiles
        } else {
            throw Errors.ParsingDataError("profiles")
        }
    }
    
}
