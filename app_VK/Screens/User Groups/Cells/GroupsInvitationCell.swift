//
//  GroupsInvitationCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 11.10.2020.
//

import UIKit
import SDWebImage

class GroupsInvitationCell: UITableViewCell {

    static let identifier = "GroupsInvitationCell"
    static let nibName = "GroupsInvitationCell"
    static let height: CGFloat = 110
    
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
    @IBOutlet weak var invitorNameLable: UILabel!
    @IBOutlet weak var answerButton: UIButton! {
        didSet {
            answerButton.layer.cornerRadius = 10
            answerButton.backgroundColor = .blue
            answerButton.setTitleColor(.white, for: .normal)
            answerButton.setTitle("Ответить", for: .normal)
        }
    }
    @IBOutlet weak var rejectButton: UIButton! {
        didSet {
            rejectButton.layer.cornerRadius = 10
            rejectButton.backgroundColor = .lightGray
            rejectButton.setTitleColor(.blue, for: .normal)
            rejectButton.setTitle("Отклонить", for: .normal)
        }
    }
    
    
    var model: GroupsInvitationCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    func updateForModel() {
        eventImageView.sd_setImage(with: URL(string: model.eventImage), completed: nil)
        invitorImageView.sd_setImage(with: URL(string: model.invitorImage), completed: nil)
        evenNametLable.text = model.evenName
        invitorNameLable.text = model.invitorName
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
