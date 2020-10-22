//
//  NewsHeaderTableViewCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit
import SDWebImage

class NewsHeaderTableViewCell: UITableViewCell {

    static let reuseIdentifier = "NewsHeaderCell"
    static let nibName = "NewsHeaderTableViewCell"
    static let height: CGFloat = 70

    @IBOutlet private weak var creatorImageView: UIImageView!
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet private weak var subtitleLable: UILabel!
    
    var model: NewsHeaderTableViewCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    private func updateForModel() {
        creatorImageView.sd_setImage(with: URL(string: model.creatorImage), completed: nil)
        nameLable.text = model.nameLable
        subtitleLable.text = model.newsDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        creatorImageView.layer.cornerRadius = creatorImageView.frame.width / 2
        creatorImageView.clipsToBounds = true
    }
    
}
