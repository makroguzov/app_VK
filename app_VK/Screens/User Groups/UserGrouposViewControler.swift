//
//  UserGrouposViewControler.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

class UserGrouposViewControler: UIViewController, MVCTableViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.frame = view.bounds
        return tv
    }()
    
    var viewModel: TableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UserGroupsViewModel(self, with: tableView)
        
        setUpTableView()
        loadData()
    }
    
    private func setUpTableView() {
        tableView.delegate = self 
        tableView.dataSource = self

        tableView.register(UINib(nibName: UserGroupCell.nibName, bundle: nil), forCellReuseIdentifier: UserGroupCell.identifier)
        tableView.register(UINib(nibName: GroupsInvitationCell.nibName, bundle: nil), forCellReuseIdentifier: GroupsInvitationCell.identifier)
    
        view.addSubview(tableView)
    }
    
    private func loadData() {
        guard let dataloader = viewModel.dataLoader as? UserGroupsDataLoader else {
            print("Problems with loading data in class: \(#file) at function: \(#function). Encorrect dataLoader type")
            return
        }
        
        dataloader.load(dataFor: [.invitations, .friend])
    }
    
    func reloadData(with newData: [Int: TableSection]) {
        
        //print(newData[1]?.rows)
        
        viewModel.setUp(with: newData)
        tableView.reloadData()
    }
}

extension UserGrouposViewControler: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRowAt(indexPath: indexPath)
    }
    
}

extension UserGrouposViewControler: UITableViewDelegate {
    
}
