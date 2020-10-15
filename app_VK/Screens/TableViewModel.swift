//
//  TableViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

protocol TableViewModel {

    var tableView: UITableView { get }
    
    init(_ tableView: UITableView)
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: SectionID) -> Int
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    
    func insert(models: [SectionID: Any])
    func update(models: [SectionID: Any])
    func delete(models at: [IndexPath])
    
}
