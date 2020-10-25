//
//  NewsImageTableViewCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

struct NewsImageTableViewCellModel {
    
    let image: Photo
    var rowHeight: CGFloat = 0

}

extension NewsImageTableViewCellModel {
    static var emptyState: NewsImageTableViewCellModel {
        return NewsImageTableViewCellModel(image: .empty)
    }
}
