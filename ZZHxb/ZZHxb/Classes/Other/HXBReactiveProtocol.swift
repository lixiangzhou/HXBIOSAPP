//
//  HXBReactiveProtocol.swift
//  ZZHxb
//
//  Created by lixiangzhou on 2018/6/7.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation


@objc protocol HXBReactiveViewBinder {
    @objc optional func reactive_bind(_ vm: HXBViewModel)
}
