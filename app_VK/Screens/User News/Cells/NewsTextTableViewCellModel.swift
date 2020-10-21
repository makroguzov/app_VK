//
//  NewsTextTableViewCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import Foundation

struct NewsTextTableViewCellModel {
    
    let newsText: String

}

extension NewsTextTableViewCellModel {
    static var emptyState: NewsTextTableViewCellModel {
        return NewsTextTableViewCellModel(newsText: "")
    }
}
