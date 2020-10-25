//
//  Size.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 25.10.2020.
//

import UIKit

extension Size {
    
    struct Size: Codable {
        let url: String
        let width: CGFloat
        let height: CGFloat
    }

}

enum Size {
    
    case s(Size)
    case m(Size)
    case x(Size)
    case o(Size)
    case p(Size)
    case q(Size)
    case r(Size)
    case y(Size)
    case z(Size)
    case w(Size)
    
    case none(String)
    
    var size: Size? {
        switch self {
        case .s(let size):
            return size
        case .m(let size):
            return size
        case .x(let size):
            return size
        case .o(let size):
            return size
        case .p(let size):
            return size
        case .q(let size):
            return size
        case .r(let size):
            return size
        case .y(let size):
            return size
        case .z(let size):
            return size
        case .w(let size):
            return size
        case .none(_):
            return nil
        }
    }
    
}

extension Size: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case url, width, height, type
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            let url = try container.decode(String.self, forKey: .url)
            let width = try container.decode(Int.self, forKey: .width)
            let height = try container.decode(Int.self, forKey: .height)
            
            let size = Size(url: url,
                            width: CGFloat(width),
                            height: CGFloat(height)
            )
            
            
            let type = try container.decode(String.self, forKey: .type)
            
            switch type {
            case "s":
                self = .s(size)
                return
            case "m":
                self = .m(size)
                return
            case "x":
                self = .x(size)
                return
            case "o":
                self = .o(size)
                return
            case "p":
                self = .p(size)
                return
            case "q":
                self = .q(size)
                return
            case "r":
                self = .r(size)
                return
            case "y":
                self = .y(size)
                return
            case "z":
                self = .z(size)
                return
            case "w":
                self = .w(size)
                return
            default:
                self = .none("Error")
                return
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
    
    func encode(to encoder: Encoder) throws {
        return
    }
    
}
