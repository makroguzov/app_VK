//
//  TableViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

protocol TableViewModel: UITableViewDelegate, UITableViewDataSource {

    var sections: [TableSection] { get set }
    var dataLoader: DataLoader { get set }
    
}

extension TableViewModel {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].rows[indexPath.row]
    }
}
