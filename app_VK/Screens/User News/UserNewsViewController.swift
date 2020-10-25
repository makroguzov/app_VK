//
//  UserNewsViewController.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

protocol CellForButtonsDelegate {
    func didTapCompleteButton(indexPath: IndexPath)
}	

class UserNewsViewController: UITableViewController {
    
    private var viewModel: UserNewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UserNewsViewModel(tableView, controller: self)
        
        setUpTableView()
        loadData()
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: NewsHeaderTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: NewsHeaderTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: NewsTextTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: NewsTextTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: NewsImageTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: NewsImageTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: NewsFooterTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: NewsFooterTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: NewsSeparatorTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: NewsSeparatorTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: NewsDefaultTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: NewsDefaultTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: NewsWebViewTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: NewsWebViewTableViewCell.reuseIdentifier)
    
        tableView.separatorStyle = .none
    }
    
    private func loadData() {
        viewModel.dataLoader.loadData()
    }
}

//MARK: UITableViewDataSource

extension UserNewsViewController {
    
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

extension UserNewsViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = viewModel.getRow(at: indexPath)
        switch row {
        case .NewsHeaderTableViewCell(let model):
            return model.rowHeight
        case .NewsTextTableViewCell(let model):
            return model.rowHeight
        case .NewsImageTableViewCell(let model):
            return model.rowHeight
        case .NewsFooterTableViewCell(let model):
            return model.rowHeight
        case .NewsSeparatorTableViewCell:
            return 20
        case .NewsDefaultTableViewCell:
            return 100
        case .NewsWebViewTableViewCell:
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsSeparatorTableViewCell.height
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsSeparatorTableViewCell.reuseIdentifier) as? NewsSeparatorTableViewCell else {
            fatalError()
        }
        
        return cell
    }
    
}


