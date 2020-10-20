//
//  UserFriendsViewController.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 14.10.2020.
//

import UIKit

class UserFriendsViewController: UITableViewController {
    
    private var viewModel: UserFriendsViewModel!
    private typealias Section = UserFriendsViewModel.Section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UserFriendsViewModel(tableView, controller: self)
        
        setUpTableView()
        loadData()
    }

    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: UserFriendCell.nibName, bundle: nil), forCellReuseIdentifier: UserFriendCell.identifier)
        tableView.register(UINib(nibName: RequestForFrCell.nibName, bundle: nil), forCellReuseIdentifier: RequestForFrCell.identifier)
    
        tableView.separatorStyle = .none
    }

    func loadData() {
        viewModel.loader.loadData(for: [.friends, .requestsForFriends])
    }
    
}

//MARK: UITableViewDataSource

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
        switch indexPath.section {
        case 0:
            return RequestForFrCell.height
        default:
            return UserFriendCell.height
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

