//
//  HXBNetActivityManager.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/15.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift

class HXBNetActivityManager: NSObject {
    static let shared = HXBNetActivityManager()
    
    let requestCount = MutableProperty(0)
    
    
    private override init() {
        super.init()
        
        UIApplication.shared.reactive.makeBindingTarget { $0.isNetworkActivityIndicatorVisible = $1 } <~ requestCount.signal.map { $0 > 0 }
    }
    
    private var lock = NSLock()
    
    func sendRequest() {
        safeCount {
            requestCount.value += 1
        }
    }
    
    func finishRequest() {
        safeCount {
            requestCount.value -= 1
        }
    }
    
    private func safeCount(_ count: () -> Void) {
        lock.lock()
        count()
        lock.unlock()
    }
    
    static func sendRequest() {
        HXBNetActivityManager.shared.sendRequest()
    }
    
    static func finishRequest() {
        HXBNetActivityManager.shared.finishRequest()
    }
    
}
