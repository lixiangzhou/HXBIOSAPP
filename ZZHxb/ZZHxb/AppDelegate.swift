//
//  AppDelegate.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import SwiftyBeaver
import IQKeyboardManagerSwift

let log = SwiftyBeaver.self

import XZLib

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss.SSS$d $C$L$c $N.$F$l: $M"
        log.addDestination(console)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 30
        
        window = UIWindow()
        
        window?.backgroundColor = .white
        
        window?.rootViewController = HXBTabBarController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

