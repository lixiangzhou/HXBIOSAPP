//
//  HXBNetworkError.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/15.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation

/*

 */

extension hxb {
    struct code {
        /// 无token权限 【401】响应头
        static let tokenInvalid = 401
        /// 未登录 【402】响应头
        static let notLogin = 402
        /// 成功 【0】
        static let success = 0
        /// 图验校验错误次数超过10次 【411】
        static let captchaLimit = 411
        /// Form错误处理字段 【104】
        static let formProcessFailed = 104
        /// 您的手机时间不在地球上，请检查后使用【412】
        static let requestOverRun = 412
        /// 图形验证码不能为空 【102】
        static let captchaCantEmpty = 102
        /// 普通错误状态码
        static let commonError = 1
    }
}

enum HXBNetworkError: Error {
    case requestUrlNil
    case encodingFailed(error: Error)
    case requestAdaptReturnNil
}


