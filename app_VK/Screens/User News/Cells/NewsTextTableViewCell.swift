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
    static let textNonExpandHeight: CGFloat = 30

    @IBOutlet private weak var newsText: UILabel!
    @IBOutlet private weak var expandButton: UIButton!
    
    
    var expandAction: ((CGFloat) -> Void)?

    var model: NewsTextTableViewCellModel = .emptyState {
        didSet {
            updateForModel()
        }
    }
    
    private func updateForModel() {
        newsText.attributedText = model.attrString
        newsText.isUserInteractionEnabled = true
        
        let rowHeight = getRowHeight(frame: frame)
        
        if rowHeight < model.rowHeight {
            expandButton.isHidden = true
        }
    }
    
    private func getRowHeight(frame: CGRect)-> CGFloat {
        let size = model.attrString.boundingRect(with: CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        return size.height
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func expand(_ sender: UIButton) {
        if !expandButton.isSelected {
            expandButton.isHidden = true
            expandAction?(getRowHeight(frame: frame))
        } else {
            
        }
    }

}
