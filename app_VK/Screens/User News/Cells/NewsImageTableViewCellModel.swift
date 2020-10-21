//
//  NewsImageTableViewCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct NewsImageTableViewCellModel {
    
    let image: String
    
}

extension NewsImageTableViewCellModel {
    static var emptyState: NewsImageTableViewCellModel {
        return NewsImageTableViewCellModel(image: "")
    }
}
