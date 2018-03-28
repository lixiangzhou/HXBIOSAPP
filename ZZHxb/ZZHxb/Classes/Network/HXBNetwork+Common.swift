//
//  HXBNetwork+Common.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/3.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

extension HXBNetwork {
    /// 发送验证码
    static func sendVerifyCode(params: HXBRequestParam?, configRequstClosure: HXBRequestConfigClosrue? = nil, completionClosure: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.verifyCode, params: params, method: .post, configRequstClosure: configRequstClosure, completionClosure: completionClosure)
    }
}
