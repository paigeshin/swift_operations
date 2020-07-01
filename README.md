# swift_operations

[https://www.avanderlee.com/swift/operations/](https://www.avanderlee.com/swift/operations/)

### What is an operation in Swift?

- An Operation is typically responsible for a single synchronous task. It’s an abstract class and never used directly. You can make use of the system-defined BlockOperation subclass or by creating your own subclass. You can start an operation by adding it to an OperationQueue or by manually calling the start method. However, it’s highly recommended to give full responsibility to the OperationQueue to manage the state.

### Basic Operation

```swift
let blockOperation = BlockOperation {
    print("Executing!")
}

let queue = OperationQueue()
queue.addOperation(blockOperation)

queue.addOperation {
    print("Operation2")
}
```

### Custom Operation

```swift
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
```

- The main() function is the only method you need to overwrite for synchronous operations.

```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = OperationQueue()
        let fileURL = URL(fileURLWithPath: "..")
        let contentImportOperation = ContentImportOperation(itemProvider: NSItemProvider(contentsOf: fileURL)!)
        contentImportOperation.completionBlock = {
            print("Importing completed!")
        }
        queue.addOperation(contentImportOperation)
        
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
```

### Different States of an operation

- **Ready:** It’s prepared to start
- **Executing:** The task is currently running
- **Finished:** Once the process is completed
- **Canceled:** The task canceled

### Creating a custom operation

```swift
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
```
