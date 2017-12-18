//
//  HXBNetworkHUDDelegate.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/15.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation

protocol HXBNetworkHUDDelegate: NSObjectProtocol {
    func showProgress()
    func hideProgress()
    func show(toast: String)
}
