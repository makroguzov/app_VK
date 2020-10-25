//
//  NewsFooterTableViewCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

struct NewsFooterTableViewCellModel {
    
    let likesCount: Int
    let userLikes: Int
    let canLike: Int
    let canPublish: Int
    
    let commentsCount: Int
    let canComment: Int
    
    let repostsCount: Int
    let userReposted: Int

    let viewsCount: Int
    
    var rowHeight: CGFloat {
        return NewsFooterTableViewCell.height
    }

}

extension NewsFooterTableViewCellModel {
    static var emptyState: NewsFooterTableViewCellModel {
        return NewsFooterTableViewCellModel(likesCount: 0,
                                            userLikes: 0,
                                            canLike: 0,
                                            canPublish: 0,
                                            commentsCount: 0,
                                            canComment: 0,
                                            repostsCount: 0,
                                            userReposted: 0,
                                            viewsCount: 0)
    }
}

extension NewsFooterTableViewCellModel {
    static func setUp(for like: Like, for comment: Comment, for repost: Repost, for views: Views) -> NewsFooterTableViewCellModel {
        return NewsFooterTableViewCellModel(likesCount: like.count,
                                            userLikes: like.userLikes,
                                            canLike: like.canLike,
                                            canPublish: like.canPublish,
                                            commentsCount: comment.count,
                                            canComment: comment.canComment,
                                            repostsCount: repost.count,
                                            userReposted: repost.userReposted,
                                            viewsCount: views.count)
    }
}
