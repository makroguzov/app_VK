//
//  NewsWebViewTableViewCell.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit
import WebKit

class NewsWebViewTableViewCell: UITableViewCell {
 
    static let reuseIdentifier = "NewsWebViewCell"
    static let nibName = "NewsWebViewTableViewCell"
 
    @IBOutlet private weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //configure(player: <#T##String#>)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configure(player: String) {
        let myURL = URL(string:player)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
