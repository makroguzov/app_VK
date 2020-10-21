//
//  NewsFooterTableViewCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct NewsFooterTableViewCellModel {
    
    let count: Int
    let userLikes: Int
    let canLike: Int
    let canPublish: Int
    
}

extension NewsFooterTableViewCellModel {
    static var emptyState: NewsFooterTableViewCellModel {
        return NewsFooterTableViewCellModel(count: 0,
                                            userLikes: 0,
                                            canLike: 0,
                                            canPublish: 0)
    }
}

extension NewsFooterTableViewCellModel {
    static func setUp(for like: Like) -> NewsFooterTableViewCellModel {
        return NewsFooterTableViewCellModel(count: like.count,
                                            userLikes: like.userLikes,
                                            canLike: like.canLike,
                                            canPublish: like.canPublish)
    }
}
