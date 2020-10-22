//
//  NewsHeaderTableViewCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct NewsHeaderTableViewCellModel {
    
    let creatorImage: String
    let nameLable: String
    let newsDate: String
    
}

extension NewsHeaderTableViewCellModel {
    static var emptyState: NewsHeaderTableViewCellModel {
        return NewsHeaderTableViewCellModel(creatorImage: "",
                                            nameLable: "",
                                            newsDate: "")
    }
}

extension NewsHeaderTableViewCellModel {
    static func setUp(for creator: Creator, postDate: String) -> NewsHeaderTableViewCellModel {
        return NewsHeaderTableViewCellModel(creatorImage: creator.image,
                                            nameLable: creator.name,
                                            newsDate: postDate)
    }
}
