//
//  AppDelegate.swift
//  Swift Background Task
//
//  Created by shin seunghyun on 2020/07/01.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import BackgroundTasks

//We cannot perform longer background tasks in iOS 13. The background task time is limited to 30 seconds.

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        return true
    }

    

}

