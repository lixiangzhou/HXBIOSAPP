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
    static let baseUrl = ""
    static let userAgentKey = "X-Hxb-User-Agent"
    static let tokenKey = "X-Hxb-Auth-Token"
    static let baseHeaderFields = ["X-Request-Id": UIDevice.current.identifierForVendor?.uuidString ?? "",
                                   "X-Hxb-Auth-Timestamp": Date().timeIntervalSince1970.description,
                                   "IDFA": ASIdentifierManager.shared().advertisingIdentifier.uuidString]
}
