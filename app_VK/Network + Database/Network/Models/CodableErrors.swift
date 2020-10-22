//
//  CodableErrors.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

enum CodableErrors: Error {
    case DecodeError(String, String, String)
}
