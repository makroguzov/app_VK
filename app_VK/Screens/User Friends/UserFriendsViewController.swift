//
//  UserFriendsViewController.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 14.10.2020.
//

import UIKit

class UserFriendsViewController: UITableViewController {
    
    private var viewModel: TableViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        loadData()
    }

    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: UserFriendCell.nibName, bundle: nil), forCellReuseIdentifier: UserFriendCell.identifier)
        //tableView.register(UINib(nibName: GroupsInvitationCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsInvitationCell.identifier)
    
        tableView.separatorStyle = .none
    }

    func loadData() {

    }
    
    func update(section: Int, deletions: [Int], insertions: [Int], modifications: [Int]) {
        
    }

}

extension UserFriendsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRowAt(indexPath: indexPath)
    }
        
}

//MARK: UITableViewDelegate

extension UserFriendsViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

