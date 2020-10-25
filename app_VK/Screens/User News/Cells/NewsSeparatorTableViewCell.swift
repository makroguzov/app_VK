//
//  NewsSeparatorTableViewCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

class NewsSeparatorTableViewCell: UITableViewCell {

    static let reuseIdentifier = "NewsSeparatorCell"
    static let nibName = "NewsSeparatorTableViewCell"
    static let height: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }
    
}
