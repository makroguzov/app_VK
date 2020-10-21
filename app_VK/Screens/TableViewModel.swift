//
//  TableViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

protocol TableViewModel {
    associatedtype Sections
    
    var tableView: UITableView { get }
    var controller: UIViewController { get }
    
    init(_ tableView: UITableView, controller: UIViewController)
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: SectionID) -> Int
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    
    func insert(models: [Sections])
    func update(models: [Sections])
    func delete(models at: [IndexPath])
    
}

extension TableViewModel {
    func printError(at function: String, error: String) {
        print("Error in class: \(#file) at function: \(function). \(error)")
    }
}
