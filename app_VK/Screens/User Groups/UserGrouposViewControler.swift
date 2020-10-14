//
//  UserGrouposViewControler.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class UserGrouposViewControler: MVCTableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        loadData()
    }
    
    private func setUpTableView() {
        tableView.delegate = self 
        tableView.dataSource = self
        
        print(self)

        tableView.register(UINib(nibName: UserGroupCell.nibName, bundle: nil), forCellReuseIdentifier: UserGroupCell.identifier)
        tableView.register(UINib(nibName: GroupsInvitationCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsInvitationCell.identifier)
    
        tableView.separatorStyle = .none
    }
    
    private func loadData() {
        guard let dataloader = viewModel.dataLoader as? UserGroupsDataLoader else {
            print("Problems with loading data in class: \(#file) at function: \(#function). Encorrect dataLoader type")
            return
        }
        
        dataloader.load(dataFor: [.invitations, .friend])
    }
    
    override func reloadData(with newData: [Int: TableSectionModel]) {
        super.reloadData(with: newData)
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource

extension UserGrouposViewControler {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(viewModel.numberOfSections())
        
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
        return viewModel.get(section: indexPath.section).height(for: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  viewModel.get(section: section).titleForHeaderInSection()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.get(section: section).heightForHeaderInSection()
    }
}
