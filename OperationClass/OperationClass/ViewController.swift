//
//  ViewController.swift
//  OperationClass
//
//  Created by shin seunghyun on 2020/07/01.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = OperationQueue()
        let fileURL = URL(fileURLWithPath: "..")
        let contentImportOperation = ContentImportOperation(itemProvider: NSItemProvider(contentsOf: fileURL)!)
        contentImportOperation.completionBlock = {
            print("Importing completed!")
        }
        let contentUploadOperation = UploadContentOperation()
        contentUploadOperation.addDependency(contentUploadOperation)
        contentUploadOperation.completionBlock = {
            print("Uploading completed!")
        }
        
        queue.addOperations([contentImportOperation, contentUploadOperation], waitUntilFinished: true)
        
    }

    private func basicOperationExample() {
        let blockOperation = BlockOperation {
            print("Executing!")
        }
        
        let queue = OperationQueue()
        queue.addOperation(blockOperation)
        
        
        queue.addOperation {
            print("Operation2")
        }
    }
    

}

//Custom Operation
class ContentImportOperation: Operation {
    
    let itemProvider: NSItemProvider
    
    init(itemProvider: NSItemProvider) {
        self.itemProvider = itemProvider
        super.init()
    }
    
    override func main() {
        super.main()
        guard !isCancelled else { return }
        print("Importing content..")
        
        // .. import the content using the item provider.
    }
    
}

class UploadContentOperation: Operation {
    
    override func main() {
        guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else {
            return
        }
        print("Uploading content..")
    }
    
}
