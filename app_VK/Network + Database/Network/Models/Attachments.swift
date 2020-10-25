//
//  Attachment.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

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
    
    case none(String)
    
    enum CodingKeys: String, CodingKey {
        case photo, video, audio, doc ,graffiti, link, note, poll, page, album, event
        case photosList = "photos_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            if container.contains(.photo) {
                try self = .photo(container.decode(Photo.self, forKey: .photo))
                return
            }
            
            if container.contains(.video) {
                try self = .video(container.decode(Video.self, forKey: .video))
                return
            }
            
            if container.contains(.link) {
                try self = .link(container.decode(Link.self, forKey: .link))
                return
            }
            
            if container.contains(.album) {
                print(CodingKeys.album)
            }
            
            if container.contains(.audio) {
                print(CodingKeys.audio)
            }
            
            if container.contains(.doc) {
                print(CodingKeys.doc)
            }
            
            if container.contains(.event) {
                print(CodingKeys.event)
            }
            
            if container.contains(.graffiti) {
                print(CodingKeys.graffiti)
            }
            
            if container.contains(.note) {
                print(CodingKeys.note)
            }
            
            if container.contains(.page) {
                print(CodingKeys.page)
            }
            
            if container.contains(.photosList) {
                print(CodingKeys.photosList)
            }
            
            if container.contains(.poll) {
                print(CodingKeys.poll)
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
        
        self = .none("Error")
    }
    
    func encode(to encoder: Encoder) throws {
        return
    }
}
