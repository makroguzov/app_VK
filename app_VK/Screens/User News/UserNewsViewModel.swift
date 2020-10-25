//
//  UserNewsViewModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 21.10.2020.
//

import UIKit

class UserNewsViewModel: TableViewModel {
    
    private enum Errors: Error {
        case UnknownSection(String)
        case ReuseError(String)
    }
    
    enum Sections {
        enum Row {
            case NewsHeaderTableViewCell(NewsHeaderTableViewCellModel)
            case NewsTextTableViewCell(NewsTextTableViewCellModel)
            case NewsImageTableViewCell(NewsImageTableViewCellModel)
            case NewsFooterTableViewCell(NewsFooterTableViewCellModel)
            case NewsSeparatorTableViewCell
            case NewsDefaultTableViewCell
            case NewsWebViewTableViewCell
        }
        
        case post([Row])
        
        var rows: [Row] {
            switch self {
            case .post(let rows):
                return rows
            }
        }
        
        subscript(row: Int) -> Row {
            get {
                rows[row]
            }
            
            set {
                switch self {
                case .post(var rows):
                    rows[row] = newValue
                    self = .post(rows)
                }
            }
        }
    }
    
    
    var tableView: UITableView
    var controller: UIViewController
    
    var dataLoader: UserNewsDataLoader!
    
    private var sections = [Sections]()
    
    
    required init(_ tableView: UITableView, controller: UIViewController) {
        self.tableView = tableView
        self.controller = controller
        
        self.dataLoader = UserNewsDataLoader(viewModel: self)
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfRowsInSection(section: SectionID) -> Int {
        return sections[section].rows.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section][indexPath.row]
        
        do {
            switch row {
            case .NewsHeaderTableViewCell(let model):
                return try getNewsHeaderTableViewCell(for: model)
            case .NewsTextTableViewCell(var model):
                let cell = try getNewsTextTableViewCell(for: model)
                
                cell.expandAction = { [weak self] (height) in
                    guard let self = self else {
                        return
                    }
                    
                    model.rowHeight = height
                    
                    var section = self.sections[indexPath.section]
                    section[indexPath.row] = .NewsTextTableViewCell(model)
                    self.update(with: [section], at: [indexPath])
                }
                
                return cell

            case .NewsImageTableViewCell(let model):
                return try getNewsImageTableViewCell(for: model)
            case .NewsFooterTableViewCell(let model):
                return try getNewsFooterTableViewCell(for: model)
            case .NewsSeparatorTableViewCell:
                return try getNewsSeparatorTableViewCell()
            case .NewsDefaultTableViewCell:
                return try getNewsDefaultTableViewCell()
            case .NewsWebViewTableViewCell:
                return try getNewsWebViewTableViewCell()
            }
        } catch Errors.ReuseError(let cell) {
            printError(at: #function, error: "Problems with reuse cell: \(cell).")
        } catch {
            printError(at: #function, error: "Unknown error.")
        }
        
        return UITableViewCell()
    }
    
    private func getNewsHeaderTableViewCell(for model: NewsHeaderTableViewCellModel) throws -> NewsHeaderTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderTableViewCell.reuseIdentifier) as? NewsHeaderTableViewCell else {
            throw Errors.ReuseError("NewsHeaderTableViewCell")
        }
        
        cell.model = model
        return cell
    }
    
    private func getNewsTextTableViewCell(for model: NewsTextTableViewCellModel) throws -> NewsTextTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextTableViewCell.reuseIdentifier) as? NewsTextTableViewCell else {
            throw Errors.ReuseError("NewsTextTableViewCell")
        }
        
        cell.model = model
        return cell
    }
    
    private func getNewsImageTableViewCell(for model: NewsImageTableViewCellModel) throws -> NewsImageTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageTableViewCell.reuseIdentifier) as? NewsImageTableViewCell else {
            throw Errors.ReuseError("NewsImageTableViewCell")
        }
        
        print(123)
        print(model)
        print(cell)
        
        cell.model = model
        return cell
    }
    
    private func getNewsFooterTableViewCell(for model: NewsFooterTableViewCellModel) throws -> NewsFooterTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterTableViewCell.reuseIdentifier) as? NewsFooterTableViewCell else {
            throw Errors.ReuseError("NewsFooterTableViewCell")
        }
        
        cell.model = model
        return cell
    }
    
    private func getNewsSeparatorTableViewCell() throws -> NewsSeparatorTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsSeparatorTableViewCell.reuseIdentifier) as? NewsSeparatorTableViewCell else {
            throw Errors.ReuseError("NewsSeparatorTableViewCell")
        }
        
        return cell
    }
    
    private func getNewsDefaultTableViewCell() throws -> NewsDefaultTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsDefaultTableViewCell.reuseIdentifier) as? NewsDefaultTableViewCell else {
            throw Errors.ReuseError("NewsDefaultTableViewCell")
        }
        
        return cell
    }
    
    private func getNewsWebViewTableViewCell() throws -> NewsWebViewTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsWebViewTableViewCell.reuseIdentifier) as? NewsWebViewTableViewCell else {
            throw Errors.ReuseError("NewsWebViewTableViewCell")
        }
        
        return cell
    }
    
    func getRow(at indexPath: IndexPath) -> Sections.Row {
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    func insert(models: [Sections]) {
        models.forEach { sections.append($0) }
        tableView.reloadData()
    }
    
    func update(with models: [Sections], at indexPaths: [IndexPath]) {
        let updations = zip(models, indexPaths)
        for (section, indexpath) in updations {
            sections[indexpath.section] = section
        }
     
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }

    func delete(models at: [IndexPath]) {
        
    }
    
}
