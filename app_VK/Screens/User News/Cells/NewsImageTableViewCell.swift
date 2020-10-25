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
            print(model)
            updateForModel()
        }
    }
    
    private func updateForModel() {
        var height: CGFloat = 200
        var url: String = model.image.sizes.first?.size?.url ?? ""

//        if !model.image.sizes.isEmpty {
//            height = 200
//            url = model.image.sizes.first?.size?.url ?? ""
//        }
        
        
        model.rowHeight = height
        postImageView.sd_setImage(with: URL(string: url), completed: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
