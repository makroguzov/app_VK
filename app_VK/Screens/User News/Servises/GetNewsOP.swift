//
//  GetNewsOP.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 22.10.2020.
//

import Foundation

class GetNewsOP: AsyncOperation {
    
    var news: News?
    
    private var startFrom: String
    
    init(startFrom: String) {
        self.startFrom = startFrom
    }
    
    override func main() {
        let params = getRequesrParams()
        AlamofireSession.shared.getResponse(with: params) { [weak self] (response) in
            guard let self = self else {
                return
            }
   
            guard let data = try? JSONSerialization.data(withJSONObject: response, options: .withoutEscapingSlashes) else {
                self.printError(in: #file, at: #function, error: "Problems with transform to data.")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                self.news = try decoder.decode(News.self, from: data)
            } catch {
                print("\(error.localizedDescription)")
            }

            self.state = .finished
        }
    }
    
    private func getRequesrParams() -> VKRequestParametrs {
        return VKRequestParametrs(path: .newsfeed,
                                  params: [
                                    "filters": "post,photo",
                                    "start_from": startFrom,
                                    "count": 1,
                                  ]
        )
    }
}
