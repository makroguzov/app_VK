//
//  DataReloadedController.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import UIKit

protocol DataReloadedController: UIViewController {
    func reloadData(with newData: [Int: TableSection])
}
