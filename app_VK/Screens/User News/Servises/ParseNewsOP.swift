//
//  ParseNewsOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

class ParseNewsOP: Operation {
    
    var models = [UserNewsViewModel.Sections]()
    
    override func main() {
        guard let op = dependencies.first as? GetNewsOP,
              let news = op.news else {
            return
        }
        
        let groups = news.groups
        let profiles = news.profiles
        let posts = news.items
        
//            posts.forEach{
//                //let creator = getCreator(by: $0.sourceId)
//                //models.append(getSection(creator: Creator, post: $0))
//                
//            }
    }
    
//    private func getCreator(by id: Int) -> Creator {
//        return Creator(group: Group.)
//    }
    
//    private func getSection(creator: Creator, post: Post) -> UserNewsViewModel.Sections {
//
//    }
    
}
