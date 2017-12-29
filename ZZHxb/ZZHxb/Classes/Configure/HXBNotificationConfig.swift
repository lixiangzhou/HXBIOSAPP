//
//  HXBNotificationConfig.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/29.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

extension hxb {
    struct notification {
        
        struct name {
            static let notLogin = Notification.Name("notLogin")
        }
        
        /// 没有登录
        static let notLogin = Notification(name: name.notLogin)
    }
}

extension Notification {
    func post() {
        NotificationCenter.default.post(self)
    }
}
