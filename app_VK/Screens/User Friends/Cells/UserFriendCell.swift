//
//  UserFriendCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 14.10.2020.
//

import UIKit
import SDWebImage

class UserFriendCell: UITableViewCell {

    static let identifier = "UserFriendCell"
    static let nibName = "UserFriendCell"
    static let height: CGFloat = 80
    
    @IBOutlet private weak var friendImageView: UIImageView! {
        didSet {
            friendImageView.layer.cornerRadius = friendImageView.frame.width / 2
        }
    }
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet private weak var subtitleLable: UILabel!
    
    var model: UserFriendCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    private func updateForModel() {
        friendImageView.sd_setImage(with: URL(string: model.image), completed: nil)
        nameLable.text = model.name
        subtitleLable.text = model.bDate?.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
