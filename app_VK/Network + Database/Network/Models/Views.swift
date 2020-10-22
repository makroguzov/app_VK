//
//  Views.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

struct Views: Codable {

    var count: Int

}

extension Views {
    static var empty: Views {
        return Views(count: 0)
    }
}
