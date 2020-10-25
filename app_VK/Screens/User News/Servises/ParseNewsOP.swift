//
//  ParseNewsOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

class ParseNewsOP: Operation {
    
    typealias Section = UserNewsViewModel.Sections
    typealias Row = Section.Row
    
    enum Errors: Error {
        case GetCreatorError
    }
    
    var models = [UserNewsViewModel.Sections]()
    
    private var groups = [Group]()
    private var profiles = [User]()
    private var posts = [Post]()

    override func main() {
        guard let op = dependencies.first as? GetNewsOP,
              let news = op.news else {
            return
        }
        
        groups = news.groups
        profiles = news.profiles
        posts = news.items
        
        posts.forEach {
            do {
                let creator = try getCreator(by: $0.sourceId)
                models.append(getSection(creator: creator, post: $0))
            } catch {
                print("Problems with geting creator for post with id: \($0.postId)")
            }
        }
    }
    
    private func getCreator(by sourceId: Int) throws -> Creator {
        if sourceId < 0 {
            guard let group = groups.filter({ $0.id == abs(sourceId) }).first else {
                throw Errors.GetCreatorError
            }
            
            return Creator(group: group)
        } else {
            guard let user = profiles.filter({ $0.id == sourceId }).first else {
                throw Errors.GetCreatorError
            }
            
            return Creator(profile: user)
        }
    }
    
    private func getSection(creator: Creator, post: Post) -> Section {
        var rows = [Row]()
        
        let headerModel = NewsHeaderTableViewCellModel.setUp(for: creator,
                                                             postDate: post.date
        )
        let header: Row = .NewsHeaderTableViewCell(headerModel)
        rows.append(header)
        
        
        
        if post.text != "" {
            let attrString = NSMutableAttributedString(string: post.text,
                                                       attributes: TextStyles.postStyle
            )
            let textModel = NewsTextTableViewCellModel(attrString: attrString)
            
            let text: Row = .NewsTextTableViewCell(textModel)
            rows.append(text)
        }
        
        
        
        switch post.type {
        case .photo:
            if !post.photos.isEmpty {
                let imageModel = NewsImageTableViewCellModel.init(image: post.photos.first!)
                let imageCell: Row = .NewsImageTableViewCell(imageModel)
                rows.append(imageCell)
            }
        case .post:
            if !post.attachments.isEmpty {
                post.attachments.forEach { (attachment) in
                    switch attachment {
                    case .photo(let photo):
                        let imageModel = NewsImageTableViewCellModel.init(image: photo)
                        let imageCell: Row = .NewsImageTableViewCell(imageModel)
                        rows.append(imageCell)
                    case .video(_):
                        break
                    case .audio:
                        break
                    case .doc:
                        break
                    case .graffiti:
                        break
                    case .link(_):
                        break
                    case .note:
                        break
                    case .poll:
                        break
                    case .page:
                        break
                    case .album:
                        break
                    case .event:
                        break
                    case .photosList:
                        break
                    case .none(let error):
                        print(error)
                        break
                    }
                }
            }
        default:
            break
        }
        
        
        
        let footerModel = NewsFooterTableViewCellModel.setUp(for: post.likes,
                                                             for: post.comments,
                                                             for: post.reposts,
                                                             for: post.views
        )
        let footer: Row = .NewsFooterTableViewCell(footerModel)
        rows.append(footer)
        
        return Section.post(rows)
    }
    
}
