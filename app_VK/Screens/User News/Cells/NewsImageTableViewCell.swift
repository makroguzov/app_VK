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
        var url: String = ""

        model.image.sizes.forEach { (sizeType) in
            switch sizeType {
            case .x(let size):
                url = size.url
            default:
                break
            }
        }
        
        postImageView.sd_setImage(with: URL(string: url), completed: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
