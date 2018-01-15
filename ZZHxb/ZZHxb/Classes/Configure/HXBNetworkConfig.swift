//
//  HXBNetworkConfig.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/13.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import AdSupport

struct HXBNetworkConfig {
    // https://api.hongxiaobao.com
    // http://192.168.1.36:3100
    static let baseUrl = "http://192.168.1.36:3100"

    static let tokenKey = "X-Hxb-Auth-Token"
    static let baseHeaderFields = ["X-Request-Id": UIDevice.current.identifierForVendor?.uuidString ?? "",
                                   "X-Hxb-Auth-Timestamp": Double(Date().timeIntervalSince1970 * 1000).description,
                                   "IDFA": ASIdentifierManager.shared().advertisingIdentifier.uuidString,
                                   "X-Hxb-User-Agent": "\(UIDevice.current.zz_version)/IOS \(UIDevice.current.systemVersion)/v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "") iphone"]
}
