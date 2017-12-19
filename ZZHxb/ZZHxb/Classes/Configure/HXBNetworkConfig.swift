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
    static let baseUrl = "http://192.168.1.26:3100"

    static let tokenKey = "X-Hxb-Auth-Token"
    static let baseHeaderFields = ["X-Request-Id": UIDevice.current.identifierForVendor?.uuidString ?? "",
                                   "X-Hxb-Auth-Timestamp": Date().timeIntervalSince1970.description,
                                   "IDFA": ASIdentifierManager.shared().advertisingIdentifier.uuidString,
                                   "X-Hxb-User-Agent": "\(UIDevice.current.zz_version)/IOS \(UIDevice.current.systemVersion)/v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "") iphone"]
}
