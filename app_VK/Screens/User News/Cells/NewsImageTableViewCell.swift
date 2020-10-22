//
//  NewsImageTableViewCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit
import SDWebImage

class NewsImageTableViewCell: UITableViewCell {

    static let reuseIdentifier = "NewsImageCell"
    static let nibName = "NewsImageTableViewCell"
    
    
    @IBOutlet private weak var postImageView: UIImageView!
    
    var model: NewsImageTableViewCellModel = .emptyState {
        didSet {
           updateForModel()
        }
    }
    
    private func updateForModel() {
        postImageView.sd_setImage(with: URL(string: model.image), completed: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
