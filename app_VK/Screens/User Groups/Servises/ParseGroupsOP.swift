//
//  ParseGroupsOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 16.10.2020.
//

import Foundation

class ParseGroupsOP: Operation {
    
    enum Errors: Error {
        case TransformToDataError(String, String)
        case DecodeError(String, String)
    }

    private var decoder = JSONDecoder()
    
    var groups = [Group]()
        
    override func main() {
        guard let data = dependencies.first as? GetGroupsOP else {
            return
        }
        
        do {
            try parseGroups(json: data.groups)
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
    
    private func printError(at function: String, error: String) {
        print("Error in class: ParseGroupsOP at function: \(function). \(error)")
    }
}
