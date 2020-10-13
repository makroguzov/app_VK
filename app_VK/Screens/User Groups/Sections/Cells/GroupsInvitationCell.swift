//
//  GroupsInvitationCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import UIKit

class GroupsInvitationCell: UITableViewCell {

    static let identifier = "GroupsInvitationCell"
    static let nibName = "GroupsInvitationCell"
    
    @IBOutlet weak var eventImageView: UIImageView! {
        didSet {
            eventImageView.layer.cornerRadius = eventImageView.frame.width / 2
        }
    }
    @IBOutlet weak var invitorImageView: UIImageView! {
        didSet {
            invitorImageView.layer.cornerRadius = invitorImageView.frame.width / 2
        }
    }
    @IBOutlet weak var evenNametLable: UILabel!
    @IBOutlet weak var subtitleLable: UILabel!
    @IBOutlet weak var answerButton: UIButton! {
        didSet {
            answerButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var rejectButton: UIButton! {
        didSet {
            rejectButton.layer.cornerRadius = 10
        }
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
