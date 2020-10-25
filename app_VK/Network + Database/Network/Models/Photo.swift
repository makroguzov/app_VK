//
//  Photo.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct Photo: Codable {

    enum CodingKeys: String, CodingKey {
        case id, text, date, sizes
        case albumId = "album_id"
        case ownerId = "owner_id"
    }
        
    var id: Int
    var albumId: Int
    var ownerId: Int
    
    var text: String
    var date: Double
    
    var sizes: [Size]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            id = try container.decode(Int.self, forKey: .id)
            albumId = try container.decode(Int.self, forKey: .albumId)
            ownerId = try container.decode(Int.self, forKey: .ownerId)
            text = try container.decode(String.self, forKey: .text)
            date = try container.decode(Double.self, forKey: .date)
            
            sizes = try container.decode([Size].self, forKey: .sizes)
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
    
    init(id: Int, albumId: Int, ownerId: Int, text: String, date: Double, sizes: [Size]) {
        self.id = id
        self.albumId = albumId
        self.ownerId = ownerId
        self.text = text
        self.date = date
        self.sizes = sizes
    }
}

extension Photo {
    static var empty: Photo {
        return Photo(id: 0,
                     albumId: 0,
                     ownerId: 0,
                     text: "",
                     date: 0,
                     sizes: []
        )
    }
}
