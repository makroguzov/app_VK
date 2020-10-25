//
//  CellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 20.10.2020.
//

import Foundation

protocol CellModel {
    associatedtype Model
    
    var model: Model { get set }
}
