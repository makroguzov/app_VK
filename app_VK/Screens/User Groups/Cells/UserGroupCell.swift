//
//  UserGroupCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import UIKit

class UserGroupCell: UITableViewCell {

    static let identifier = "UserGroupCell"
    static let nibName = "UserGroupCell"
    static let height: CGFloat = 70
    
    @IBOutlet weak var groupImageView: UIImageView! {
        didSet {
            groupImageView.layer.cornerRadius = groupImageView.frame.width / 2
        }
    }
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var subtitleLable: UILabel!
    
    
    var model: UserGroupCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    private func updateForModel() {
        
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
