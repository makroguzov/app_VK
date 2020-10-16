//
//  UserGrouposViewControler.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class UserGrouposViewControler: UITableViewController {
    
    var viewModel: UserGroupsTableViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UserGroupsTableViewModel(tableView, controller: self)
        
        setUpTableView()
        loadData()
    }
    
    private func setUpTableView() {
        tableView.delegate = self 
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: UserGroupCell.nibName, bundle: nil), forCellReuseIdentifier: UserGroupCell.identifier)
        tableView.register(UINib(nibName: GroupsInvitationCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsInvitationCell.identifier)
    
        tableView.separatorStyle = .none
    }
    
    private func loadData() {
        viewModel.loader.load(dataFor: [.friend, .invitations])
    }

}

//MARK: UITableViewDataSource

extension UserGrouposViewControler {
    
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

extension UserGrouposViewControler {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? GroupsInvitationCell.height : UserGroupCell.height
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Приглашения: \(viewModel.numberOfRowsInSection(section: section))" :
            "Группы: \(viewModel.numberOfRowsInSection(section: section))"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 50 : 50
    }
}
