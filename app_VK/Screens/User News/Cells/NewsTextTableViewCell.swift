//
//  NewsTextTableViewCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {

    static let reuseIdentifier = "NewsTextCell"
    static let nibName = "NewsTextTableViewCell"
    static let height: CGFloat = 60
    
    var expandAction: ((UIButton) -> Void)?

    @IBOutlet private weak var newsText: UILabel!
    @IBOutlet private weak var expandButton: UIButton!
    
    var model: NewsTextTableViewCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    private func updateForModel() {
        newsText.text = model.newsText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func expand(_ sender: UIButton) {
        expandAction?(sender)
    }

}
