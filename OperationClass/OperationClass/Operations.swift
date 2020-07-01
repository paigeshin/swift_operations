//
//  Operations.swift
//  OperationClass
//
//  Created by shin seunghyun on 2020/07/01.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation
import UIKit

class OperationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

class FetchOperation: Operation {
    
    private var detaFetched: Data?
    
    override func main() {
        super.main()
        
//        self.detaFetched = // data received
        
    }
    
}

class ParseOperation: Operation {
    
    var dataFetched: Data?
    
    private(set) var jsonParsed: [String: Any]?
    
    override func main() {
        super.main()
        guard let dataFetched: Data = dataFetched else { return }
        jsonParsed = try! JSONSerialization.jsonObject(with: dataFetched, options: []) as? [String: Any]
        print(jsonParsed)
    }
    
}

class Handler {
    
    private let queue: OperationQueue = OperationQueue()
    
    func start() {
        let fetch: FetchOperation = FetchOperation()
        let parse: ParseOperation = ParseOperation()
        parse.addDependency(fetch)
        queue.addOperations([fetch, parse], waitUntilFinished: true)
    }
    
}

class FetchOperationWithWrapper: Operation {
    
    var dataFetched: Data?
    private(set) var jsonParsed: [String: Any]?
    
    override func main() {
        super.main()
        guard let dataFetched: Data = dataFetched else { return }
        jsonParsed = try! JSONSerialization.jsonObject(with: dataFetched, options: []) as? [String: Any]
        print(jsonParsed)
    }
    
}

