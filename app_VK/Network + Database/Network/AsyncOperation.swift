//
//  AsyncOperation.swift
//  app_VK
//
//  Created by Валерий Макрогузов on 10.10.2020.
//

import Foundation
import Alamofire

typealias SectionID = Int
typealias JSON = [String: Any]

class AsyncOperation: Operation {
    
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            "is" + rawValue.capitalized
        }
    }
    
    static let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    let group = DispatchGroup()
    
    var state: State = .ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    override var isAsynchronous: Bool {
        true
    }
    
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    	
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
    
    func printError(in file: String,at function: String, error: String) {
        print("Error in class: \(file) at function: \(function). \(error)")
    }

    static func getRequest(with params: VKRequestParametrs) -> DataRequest {
        return AlamofireSession.shared.session.request(params.url,
                                                       method: .get,
                                                       parameters: params.params)
    }
    
}
