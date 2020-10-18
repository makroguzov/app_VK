//
//  RequestForFrCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 18.10.2020.
//

import UIKit
import SDWebImage

class RequestForFrCell: UITableViewCell {

    static let nibName = "RequestForFrCell"
    static let identifier = "RequestForFrCell"
    static let height: CGFloat = 110
    
    @IBOutlet private weak var imageView1: UIImageView! {
        didSet {
            imageView1.layer.cornerRadius = imageView1.frame.width / 2
            imageView1.layer.borderWidth = 3
            imageView1.layer.borderColor = UIColor.white.cgColor
            
            imageView1.clipsToBounds = true
        }
    }
    @IBOutlet private weak var imageView2: UIImageView! {
        didSet {
            imageView2.layer.cornerRadius = imageView2.frame.width / 2
            imageView2.layer.borderWidth = 3
            imageView2.layer.borderColor = UIColor.white.cgColor
            
            imageView2.clipsToBounds = true
        }
    }
    @IBOutlet private weak var imageView3: UIImageView! {
        didSet {
            imageView3.layer.cornerRadius = imageView3.frame.width / 2
            imageView3.layer.borderWidth = 3
            imageView3.layer.borderColor = UIColor.white.cgColor
            
            imageView3.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var scanQRButton: UIButton! {
        didSet {
            scanQRButton.setTitle("Сканировать QR", for: .normal)
            scanQRButton.setTitleColor(.black, for: .normal)
                
            scanQRButton.backgroundColor = .lightGray
            scanQRButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var addFriendButton: UIButton! {
        didSet {
            addFriendButton.setTitle("Добавить друга", for: .normal)
            addFriendButton.setTitleColor(.black, for: .normal)
                
            addFriendButton.backgroundColor = .lightGray
            addFriendButton.layer.cornerRadius = 10
        }
    }

    var model: RequestForFrCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    private func updateForModel() {
        imageView1.sd_setImage(with: URL(string: model.image1), completed: nil)
        imageView2.sd_setImage(with: URL(string: model.image2), completed: nil)
        imageView3.sd_setImage(with: URL(string: model.image3), completed: nil)
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
