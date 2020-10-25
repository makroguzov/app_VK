//
//  Post.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

struct Post: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type, date, text, comments, likes, views, reposts, photos, video, attachments
        case sourceId = "source_id"
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case postId = "post_id"
    }
    
    enum PostType: String, Codable {
        case post, photo, friend, note, audio, video
        case photoTag = "photo_tag"
        case wallPhoto = "wall_photo"
        
        case none
    }
    
    var type: PostType = .none
    var postId: Int
    var sourceId: Int //положительный — новость пользователя, отрицательный — новость группы
    
    var date: String = ""
    
    var text: String = ""
    
    var canEdit: Int = 0
    var canDelete: Int = 0
    
    var comments: Comment = .empty
    var likes: Like = .empty
    var reposts: Repost = .empty
    var views: Views = .empty
    
    var photos: [Photo] = []
    var video: Video?
    
    var attachments = [Attachment]()
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
                
        if let canEdit = try? container.decode(Int.self, forKey: .canEdit) {
            self.canEdit = canEdit
        }
        
        if let canDelete = try? container.decode(Int.self, forKey: .canDelete) {
            self.canDelete = canDelete
        }
        
        if let views = try? container.decode(Views.self, forKey: .views) {
            self.views = views
        }
        
        
        do {
            postId = try container.decode(Int.self, forKey: .postId)
            sourceId = try container.decode(Int.self, forKey: .sourceId)
            
            let time = try container.decode(Double.self, forKey: .date)
            date = Date(timeIntervalSince1970: time).timeAgo(numericDates: false)
            
            type = try PostType(rawValue: container.decode(String.self, forKey: .type)) ?? .none
            
            switch type {
            case .photo:
                if let photos = try? container.decode([Photo].self, forKey: .photos) {
                    self.photos = photos
                }
            case .post:
                text = try container.decode(String.self, forKey: .text)
                
                comments = try container.decode(Comment.self, forKey: .comments)
                likes = try container.decode(Like.self, forKey: .likes)
                reposts = try container.decode(Repost.self, forKey: .reposts)
                
                if let attachments = try? container.decode([Attachment].self, forKey: .attachments) {
                    self.attachments = attachments
                }
            case .friend:
                return
            case .note:
                return
            case .audio:
                return
            case .video:
                return
            case .photoTag:
                return
            case .wallPhoto:
                return
            case .none:
                print("Error in class: Post at function:\(#function). Undefind Post type.")
            }
        } catch DecodingError.dataCorrupted(let context) {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: context.codingPath,
                                  debugDescription: "\(context.debugDescription) in file \(#file)")
            )
        } catch let DecodingError.keyNotFound(keys, context) {
            throw DecodingError.keyNotFound(keys, DecodingError.Context(codingPath: context.codingPath,
                                                                        debugDescription: "\(context.debugDescription) in file \(#file)")
            )
        } catch let DecodingError.typeMismatch(type, context) {
            throw DecodingError.typeMismatch(type, .init(codingPath: context.codingPath,
                                                         debugDescription: "\(context.debugDescription) in file \(#file)")
            )
        } catch let DecodingError.valueNotFound(type, context) {
            throw DecodingError.valueNotFound(type, .init(codingPath: context.codingPath,
                                                          debugDescription: "\(context.debugDescription) in file \(#file)")
            )
        }
    }
}
