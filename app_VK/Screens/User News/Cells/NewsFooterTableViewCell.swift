//
//  NewsFooterTableViewCell1.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

class NewsFooterTableViewCell: UITableViewCell {

    static let reuseIdentifier = "NewsFooterCell"
    
    @IBOutlet private weak var likeButton: UIButton! {
        didSet {
            likeButton.setImage(UIImage(systemName: ""), for: <#T##UIControl.State#>)
        }
    }
    @IBOutlet private weak var likeLabel: UILabel!
    
    @IBOutlet private weak var commentLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var commentButton: UIButton!
    @IBOutlet private weak var commentLabel: UILabel!
    
    
    @IBOutlet private weak var commentLabelWidth: NSLayoutConstraint!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var shareLabel: UILabel!
    
    @IBOutlet private weak var iconCommentWidth: NSLayoutConstraint!
    @IBOutlet private weak var iconViews: UIImageView!
    @IBOutlet private weak var viewsLabel: UILabel!
    
    var delegateButton: CellForButtonsDelegate?
    var indexPathCell: IndexPath?

    var model: NewsFooterTableViewCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    private func updateForModel() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func tapLikeButton(_ sender: UIButton) {
        delegateButton?.didTapCompleteButton(indexPath: indexPathCell!)
        
        if likeButton.currentImage == UIImage(named: "HeartWhite") {
            likeButton.setImage(UIImage(named: "Heart"), for: .normal)
            likeLabel.textColor = UIColor.vkRed
            
            if let likesTest = Int(likeLabel.text!) {
                if likesTest < 1000 {
                    likeLabel.text = String(Int(likeLabel.text!)! + 1)
                }
            }
        } else {
            likeButton.setImage(UIImage(named: "HeartWhite"), for: .normal)
            likeLabel.textColor = UIColor.vk_color
            if let likesTest = Int(likeLabel.text!) {
                if likesTest < 1000 {
                    likeLabel.text = String(Int(likeLabel.text!)! - 1)
                }
            }
        }
    }
    
}
