//
//  Attachment.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

//struct Attachment: Codable {
//
//    private enum Codingkeys: String, CodingKey {
//        case type
//    }
//
//    fileprivate enum AttachmentType: String, CodingKey {
//        case photo, video, audio, doc ,graffiti, link, note, poll, page, album, event
//        case photosList = "photos_list"
//    }
    
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

        enum CodingKeys: String, CodingKey {
            case photo, video, audio, doc ,graffiti, link, note, poll, page, album, event
            case photosList = "photos_list"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if container.contains(.photo) {
                do {
                    self = .photo(try container.decode(Photo.self, forKey: .photo))
                    return
                } catch {
                    throw error
                }
            }

            if container.contains(.video) {
                do {
                    self = .video(try container.decode(Video.self, forKey: .video))
                } catch {
                    throw error
                }
            }

            if container.contains(.link) {
                do {
                    self = .link(try container.decode(Link.self, forKey: .link))
                } catch {
                    throw error
                }
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

            self = .none
            return
            
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [],
                                      debugDescription: "Problems with decoding Attachments in \(#file)")
            )
        }

        func encode(to encoder: Encoder) throws {
            return
        }
    }
    
//    var type: String
//    var element: Attachment = .none
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Codingkeys.self)
//        
//        self.type = try container.decode(String.self, forKey: .type)
//        
//        let typesContainer = try decoder.container(keyedBy: AttachmentType.self)
//        let type = AttachmentType(rawValue: self.type)
//        
//        do {
//            switch type {
//            case .photo:
//                element = .photo(try typesContainer.decode(Photo.self, forKey: .photo))
//            case .video:
//                element = .video(try typesContainer.decode(Video.self, forKey: .video))
//            case .audio:
//                return
//            case .doc:
//                return
//            case .graffiti:
//                return
//            case .link:
//                element = .link(try typesContainer.decode(Link.self, forKey: .link))
//            case .note:
//                return
//            case .poll:
//                return
//            case .page:
//                return
//            case .album:
//                return
//            case .event:
//                return
//            case .photosList:
//                return
//            case .none:
//                print("Error")
//                
//            }
//        } catch DecodingError.dataCorrupted(let context) {
//            throw DecodingError.dataCorrupted(context)
//        }
//    }
//}
