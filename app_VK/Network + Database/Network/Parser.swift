//
//  Parser.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation

protocol Parser {
    func parseData(with json: [String: Any]) -> [TableSection]
}
