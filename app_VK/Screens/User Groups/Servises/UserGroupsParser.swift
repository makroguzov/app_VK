//
//  UserGroupsParser.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit
import SDWebImage

class UserGroupsParser: Parser {
    
    enum Errors: Error {
        case ParsingDataError(String)
        case TransformToDataError(String)
        case DecodeError(String)
        case CreateSectionError(Int)
    }
    
    struct Invitations {
        var items: [Group]
        var groups: [Group]
        var profiles: [User]
    }

    private let decoder = JSONDecoder()
    private let group = DispatchGroup()

    
    override func parseData(with jsons: [Int: [String : Any]]) -> [Int: TableSectionModel] {
        guard !jsons.isEmpty else {
            return [:]
        }
        
        var sections = [Int: TableSectionModel]()

        for (sectionNum, json) in jsons {
            
            do {
                let section = try parseJSON(json, for: sectionNum)
                sections[sectionNum] = section
            } catch let Errors.CreateSectionError(section){
                print("Problems with parsing in class: UserGroupsParser at function: \(#function). Can't create section - '\(section)'.")
            } catch {
                print("Unknown error.")
            }
        }
        return sections
    }
    
    private func parseJSON(_ json: [String: Any], for section: Int) throws -> TableSectionModel {
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
    
    private func getGroupsSection(with json: [String: Any]) throws -> UserGroupsSection {
        let groups: [Group]
        
        do {
            groups = try parseItems(json: json)
        } catch let error {
            throw error
        }
 
        let groupsSection = createGroupsSection(with: groups)
        
        //print(groupsSection.rows)
        return groupsSection
    }
    
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
    
    private func createGroupsSection(with groups: [Group]) -> UserGroupsSection {
        var rows = [UserGroupCell]()
        
        for group in groups {
            let cell = self.GetCell(for: group)
            rows.append(cell)
        }
        
        return UserGroupsSection(rows: rows)
    }

    private func GetCell(for group: Group) -> UserGroupCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserGroupCell.identifier) as? UserGroupCell else {
            print("Can't find cell: UserGroupCell.")
            fatalError()
        }
        
        cell.groupImageView.sd_setImage(with: URL(string: group.photo100), completed: nil)
        cell.nameLable.text = group.name
        cell.subtitleLable.text = group.screenName
        
        return cell
    }
    
    private func getInvitationsSection(with json: [String: Any]) throws -> UserGroupsInvitationsSection {
        let invitations: Invitations
        
        do {
            let items = try parseItems(json: json)
            let groups = try parseGroups(json: json)
            let profiles = try parseProfiles(json: json)
            
            invitations = Invitations(items: items, groups: groups, profiles: profiles)
        } catch let error {
            throw error
        }
        
        let invitetionSection = createInvitationSection(with: invitations)
        return invitetionSection
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
    
    private func createInvitationSection(with invitations: Invitations) -> UserGroupsInvitationsSection {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsInvitationCell.identifier) as? GroupsInvitationCell else {
            print("Can't find cell: GroupsInvitationCell")
            fatalError()
        }
        
        
        return UserGroupsInvitationsSection(rows: [cell])
    }

}
