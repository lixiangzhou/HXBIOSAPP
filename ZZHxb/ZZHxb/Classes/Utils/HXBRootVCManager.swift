//
//  HXBRootVCManager.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBRootVCManager {
    static let shared = HXBRootVCManager()
    private init() {
    }
    
    var tabBarController: HXBTabBarController? {
        return UIApplication.shared.keyWindow?.rootViewController as? HXBTabBarController
    }
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
