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
                
        postId = try container.decode(Int.self, forKey: .postId)
        sourceId = try container.decode(Int.self, forKey: .sourceId)
        
        if let canEdit = try? container.decode(Int.self, forKey: .canEdit) {
            self.canEdit = canEdit
        }
        
        if let canDelete = try? container.decode(Int.self, forKey: .canDelete) {
            self.canDelete = canDelete
        }
        
        do {
            let time = try container.decode(Double.self, forKey: .date)
            date = Date(timeIntervalSince1970: time).timeAgo(numericDates: false)
        } catch {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [CodingKeys.date],
                                      debugDescription: "Problems with decode in \(#file)")
            )
        }
                    
        do {
            text = try container.decode(String.self, forKey: .text)
            
            comments = try container.decode(Comment.self, forKey: .comments)
            likes = try container.decode(Like.self, forKey: .likes)
            reposts = try container.decode(Repost.self, forKey: .reposts)
            views = try container.decode(Views.self, forKey: .views)
        } catch {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [CodingKeys.text,
                                                   CodingKeys.comments,
                                                   CodingKeys.likes,
                                                   CodingKeys.reposts,
                                                   CodingKeys.views],
                                      debugDescription: "Problems with decode in \(#file)")
            )
        }
                
        
        do {
            type = try PostType(rawValue: container.decode(String.self, forKey: .type)) ?? .none
        } catch {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [CodingKeys.type],
                                      debugDescription: "Problems with decode in \(#file)"
                )
            )
        }
                
        do {
            switch type {
            case .photo:
                photos = try container.decode([Photo].self, forKey: .photos)
            case .post:
                attachments = try container.decode([Attachment].self, forKey: .attachments)
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
        } catch {
            throw error
        }
        
        
//        catch DecodingError.dataCorrupted(let context) {
//            throw DecodingError.dataCorrupted(context)
//        }
    }
}