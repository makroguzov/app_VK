//
//  ParseEventsOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 15.10.2020.
//

import Foundation

class ParseEventsOP: Operation {
    
    enum Errors: Error {
        case TransformToDataError(String, String)
        case DecodeError(String, String)
    }
    
    private var decoder = JSONDecoder()
    
    var groups = [Group]()
    var profiles = [Int]()
    var events = [Group]()
    
    override func main() {
        guard let data = dependencies.first as? GetEventsOP,
              let groups = data.groups,
              let events = data.events,
              let profiles = data.profiles else {
            return
        }
    
//        #if DEBUG
//         print("Groups from GetEventsOP: ", groups)
//         print("Events from GetEventsOP: ", events)
//         print("Profiles from GetEventsOP: ", profiles)
//        #endif
        
        do {
            try parseGroups(json: groups)
            try parseProfiles(json: profiles)
            try parseEvents(json: events)
        } catch let Errors.TransformToDataError(functiuon, erorr)  {
            printError(at: functiuon, error: erorr)
        } catch let Errors.DecodeError(functiuon, error) {
            printError(at: functiuon, error: error)
        } catch {
            printError(at: #function, error: "Unknown error.")
        }
    }
    
    private func parseGroups(json: [JSON]) throws {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .withoutEscapingSlashes) else {
            throw Errors.TransformToDataError(#function, "Can't transform Groups JSON to data.")
        }
        
        guard let groups = try? decoder.decode([Group].self, from: data) else {
            throw Errors.DecodeError(#function, "Problems with decode Groups.")
        }
        
        self.groups = groups
    }
    
    private func parseProfiles(json: [JSON]) throws {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .withoutEscapingSlashes) else {
            throw Errors.TransformToDataError(#function, "Can't transform Profiles JSON to data.")
        }
        
        guard let profiles = try? decoder.decode([User].self, from: data) else {
            throw Errors.DecodeError(#function, "Problems with decode Profiles.")
        }

        self.profiles = profiles.map({ $0.id })
    }
    
    private func parseEvents(json: [JSON]) throws {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .withoutEscapingSlashes) else {
            throw Errors.TransformToDataError(#function, "Can't transform Events JSON to data.")
        }
        
        guard let events = try? decoder.decode([Group].self, from: data) else {
            throw Errors.DecodeError(#function, "Problems with decode Events.")
        }

        self.events = events
    }
    
    private func printError(at function: String, error: String) {
        print("Error in class: ParseEventsOP at function: \(function). \(error)")
    }
}
