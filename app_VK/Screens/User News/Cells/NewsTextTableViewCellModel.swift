//
//  NewsTextTableViewCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

struct NewsTextTableViewCellModel {
    
    let attrString: NSAttributedString
    var rowHeight: CGFloat = NewsTextTableViewCell.textNonExpandHeight
}

extension NewsTextTableViewCellModel {
    static var emptyState: NewsTextTableViewCellModel {
        return NewsTextTableViewCellModel(attrString: NSAttributedString(string: ""))
    }
}
