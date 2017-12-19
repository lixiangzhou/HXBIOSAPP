//
//  HXBNotification.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/19.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

extension hxb {
    struct notification {
        /// 没有登录
        static let notLogin = Notification(name: Notification.Name("notLogin"))
    }
}

extension Notification {
    func post() {
        NotificationCenter.default.post(self)
    }
}
