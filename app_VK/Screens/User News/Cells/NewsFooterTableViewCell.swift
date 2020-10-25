//
//  NewsFooterTableViewCell1.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

class NewsFooterTableViewCell: UITableViewCell {

    static let reuseIdentifier = "NewsFooterCell"
    static let nibName = "NewsFooterTableViewCell"
    static let height: CGFloat = 40
    
    @IBOutlet private weak var likeButton: UIButton! {
        didSet {
            likeButton.setImage(UIImage(systemName: ""), for: .selected)
        }
    }
    @IBOutlet private weak var likeLabel: UILabel!
    
    @IBOutlet private weak var commentLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var commentButton: UIButton!
    @IBOutlet private weak var commentLabel: UILabel!
    
    
    @IBOutlet private weak var commentLabelWidth: NSLayoutConstraint!
    @IBOutlet private weak var shareButton: UIButton! {
        didSet {
            shareButton.setImage(UIImage(systemName: ""), for: .selected)
        }
    }
    @IBOutlet private weak var shareLabel: UILabel!
    
    @IBOutlet private weak var iconCommentWidth: NSLayoutConstraint!
    @IBOutlet private weak var iconViews: UIImageView!
    @IBOutlet private weak var viewsLabel: UILabel!
    
    var indexPathCell: IndexPath?

    var model: NewsFooterTableViewCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    private func updateForModel() {
        updateLikes()
        updateComments()
        updateReposts()
        updateViews()
    }
    
    private func updateLikes() {
        likeLabel.text = String(model.likesCount)
        
        if model.userLikes == 1  {
            likeButton.isSelected.toggle()
        }
    }
    
    private func updateComments() {
        commentLabel.text = String(model.commentsCount)
        
        if model.canComment == 0 {
            commentButton.isEnabled = false
        }
    }
    
    private func updateReposts() {
        shareLabel.text = String(model.repostsCount)
        
        if model.userReposted == 1 {
            shareButton.isSelected.toggle()
        }
    }
    
    private func updateViews() {
        viewsLabel.text = String(model.viewsCount)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func tapLikeButton(_ sender: UIButton) {
        let likesCount = Int(likeLabel.text ?? "") ?? 0
        
        if likeButton.isSelected {
            likeLabel.text = String(likesCount - 1)
        } else {
            likeLabel.text = String(likesCount + 1)
        }
        
        likeButton.isSelected.toggle()
    }
    
}
