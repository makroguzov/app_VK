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
    let subtitleLable: String
    
}

extension NewsHeaderTableViewCellModel {
    static var emptyState: NewsHeaderTableViewCellModel {
        return NewsHeaderTableViewCellModel(creatorImage: "",
                                            nameLable: "",
                                            subtitleLable: "")
    }
}

extension NewsHeaderTableViewCellModel {
    static func setUp(for user: User) -> NewsHeaderTableViewCellModel {
        return NewsHeaderTableViewCellModel(creatorImage: user.photo100 ?? "",
                                            nameLable: "\(user.firstName) \(user.lastName)",
                                            subtitleLable: user.bdate?.description ?? "")
    }
}
