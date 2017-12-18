//
//  HXBNetworkHUDDelegate.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/15.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation

enum HXBHudContainerType {
    case window     /// 显示在window上
    case view       /// 显示在view上
    case none       /// 不显示
}

protocol HXBNetworkHUDDelegate: NSObjectProtocol {
    func showProgress(type: HXBHudContainerType)
    func hideProgress(type: HXBHudContainerType)
    func show(toast: String, type: HXBHudContainerType)
}
