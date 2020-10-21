//
//  News.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct News: Codable {
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
        case newOffset = "new_offset"
    }
    
    var items: Post
    var profiles: User
    var groups: Group
    
    var nextFrom: Int
    var newOffset: Int
}

struct Post: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type, date, text, comments, likes, views, reposts, attachments
        case sourceId = "source_id"
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case postId = "post_id"
    }
    
    enum PostType: String, Codable {
        case  post, photo, friend, note, audio, video
        case photoTag = "photo_tag"
        case wallPhoto = "wall_photo"
        
        case none
    }
    
    struct Comment: Codable {
        
        enum CodingKeys: String, CodingKey {
            case count
            case canPost
        }
        
        var count: Int
        var canPost: Int
        
    }
    
    
    struct Repost: Codable {
        
        enum CodingKeys: String, CodingKey {
            case count
            case userReposted = "user_reposted"
        }
        
        var count: Int
        var userReposted: Int
        
    }
    
    struct Views: Codable {
        var count: Int
    }
    
    struct Attachment: Codable {
        
        enum Codingkeys: String, CodingKey {
            case type
            case photos
            case link
        }
        
        enum AttachmentType: String, Codable {
            case photo, video, audio, doc, graffiti, link, note, poll, page, album, photos_list, event
        }
                
        var type: AttachmentType
        
    }
    
    var type: PostType
    var postId: Int
    var sourceId: Int //положительный — новость пользователя, отрицательный — новость группы
    
    var date: String
    
    var text: String
    
    var canEdit: Int
    var canDelete: Int
    
    var comments: Comment
    var likes: Like
    var reposts: Repost
    var views: Views
    
    
    var attachments: [Attachment]
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if  let type = try? container.decode(String.self, forKey: .type) {
            self.type = PostType.init(rawValue: type) ?? .none
        } else {
            self.type = PostType.none
        }
        
        postId = try container.decode(Int.self, forKey: .postId)
        sourceId = try container.decode(Int.self, forKey: .sourceId)
        date = try container.decode(String.self, forKey: .date)
        
        if let text = try? container.decode(String.self, forKey: .text) {
            self.text = text
        } else {
            self.text = ""
        }
        
        canEdit = try container.decode(Int.self, forKey: .canEdit)
        canDelete = try container.decode(Int.self, forKey: .canDelete)
        
        if let comments = try? container.decode(Comment.self, forKey: .comments) {
            self.comments = comments
        } else {
            self.comments = Comment(count: 0, canPost: 0)
        }
        
        if let likes = try? container.decode(Like.self, forKey: .likes) {
            self.likes = likes
        } else {
            self.likes = Like(count: 0, userLikes: 0, canLike: 0, canPublish: 0)
        }
        
        if let reposts = try? container.decode(Repost.self, forKey: .reposts) {
            self.reposts = reposts
        } else {
            self.reposts = Repost(count: 0, userReposted: 0)
        }
        
        if let views = try? container.decode(Views.self, forKey: .views) {
            self.views = views
        } else {
            self.views = Views(count: 0)
        }
    
        if let attachments = try? container.decode([Attachment].self, forKey: .attachments) {
            self.attachments = attachments
        } else {
            self.attachments = []
        }
    }
}

