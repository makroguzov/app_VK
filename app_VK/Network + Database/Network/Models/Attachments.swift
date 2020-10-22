//
//  Attachment.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

struct Attachment: Codable {
    
    private enum Codingkeys: String, CodingKey {
        case type
    }
    
    fileprivate enum Errors: Error {
        case DecodeError(String)
    }
    
    fileprivate enum AttachmentType: String, CodingKey {
        case photo, video, audio, doc ,graffiti, link, note, poll, page, album, event
        case photosList = "photos_list"
    }
    
    enum Attachment: Codable {
        case photo(Photo)
        case video(Video)
        case audio
        case doc
        case graffiti
        case link(Link)
        case note
        case poll
        case page
        case album
        case event
        case photosList
        
        case none
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: AttachmentType.self)
            
            if let photo = try? container.decode(Photo.self, forKey: .photo) {
                self = .photo(photo)
                return
            }
            
            if let video = try? container.decode(Video.self, forKey: .video) {
                self = .video(video)
                return
            }
            
            if let link = try? container.decode(Link.self, forKey: .link) {
                self = .link(link)
                return
            }
            
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [],
                                      debugDescription: "Problems with decoding Attachments in \(#file)")
            )
        }
        
        func encode(to encoder: Encoder) throws {
            return
        }
    }
    
    var type: String
    var element: Attachment = .none
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        
        self.type = try container.decode(String.self, forKey: .type)
        
        let typesContainer = try decoder.container(keyedBy: AttachmentType.self)
        let type = AttachmentType(rawValue: self.type)
        
        do {
            switch type {
            case .photo:
                element = try typesContainer.decode(Attachment.self, forKey: .photo)
            case .video:
                element = try typesContainer.decode(Attachment.self, forKey: .video)
            case .audio:
                return
            case .doc:
                return
            case .graffiti:
                return
            case .link:
                element = try typesContainer.decode(Attachment.self, forKey: .link)
            case .note:
                return
            case .poll:
                return
            case .page:
                return
            case .album:
                return
            case .event:
                return
            case .photosList:
                return
            case .none:
                print("Error")
                
            }
        } catch DecodingError.dataCorrupted(let context) {
            throw DecodingError.dataCorrupted(context)
        }
    }
}
