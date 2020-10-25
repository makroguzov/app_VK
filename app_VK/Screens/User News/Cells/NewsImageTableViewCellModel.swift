//
//  NewsImageTableViewCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

struct NewsImageTableViewCellModel {
    
    let image: Photo
    var rowHeight: CGFloat {
        var height: CGFloat = 0
        
        image.sizes.forEach { (sizeType) in
            switch sizeType {
            case .x(let size):
                height = size.height
            default:
                break
            }
        }
        
        return height
    }
    
}

extension NewsImageTableViewCellModel {
    static var emptyState: NewsImageTableViewCellModel {
        return NewsImageTableViewCellModel(image: .empty)
    }
}
