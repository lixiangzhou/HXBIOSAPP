//
//  HXBNetActivityManager.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/15.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBNetActivityManager: NSObject {
    static let shared = HXBNetActivityManager()
    
    var requestCount: NSInteger = 0
    
    private override init() {
        super.init()
    }
    
    private var lock = NSLock()
    
    func sendRequest() {
        lock.lock()
        requestCount += 1
        lock.unlock()
        UIApplication.shared.isNetworkActivityIndicatorVisible = self.requestCount > 0
    }
    
    func finishRequest() {
        lock.lock()
        requestCount -= 1
        lock.unlock()
        UIApplication.shared.isNetworkActivityIndicatorVisible = self.requestCount > 0
    }
    
    static func sendRequest() {
        HXBNetActivityManager.shared.sendRequest()
    }
    
    static func finishRequest() {
        HXBNetActivityManager.shared.finishRequest()
    }
    
}
