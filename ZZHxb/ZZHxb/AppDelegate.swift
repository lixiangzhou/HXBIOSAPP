//
//  AppDelegate.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss.SSS$d $C$L$c $N.$F$l: $M"
        
        log.addDestination(console)
        
        window = UIWindow()
        
        window?.backgroundColor = .white
        
        window?.rootViewController = HXBTabBarController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

