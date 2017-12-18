//
//  HXBNetworkError.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/15.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation

enum HXBNetworkError: Error {
    case requestUrlNil
    case encodingFailed(error: Error)
    case requestAdaptReturnNil
}


