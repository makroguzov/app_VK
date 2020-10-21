//
//  RequestForFrCellModel.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 18.10.2020.
//

import Foundation

struct RequestForFrCellModel {
    
    let image1: String
    let image2: String
    let image3: String
    
}

extension RequestForFrCellModel {
    static var emptyState: RequestForFrCellModel {
        return RequestForFrCellModel(image1: "",
                                     image2: "",
                                     image3: "")
    }
}

extension RequestForFrCellModel {
    static func forRequests(reqquests: [UserFriendCellModel]) -> RequestForFrCellModel {
        guard reqquests.count >= 3 else {
            return .emptyState
        }

        let req1 = reqquests[0]
        let req2 = reqquests[1]
        let req3 = reqquests[2]

        return RequestForFrCellModel(image1: req1.image,
                                     image2: req2.image,
                                     image3: req3.image)
    }
}
