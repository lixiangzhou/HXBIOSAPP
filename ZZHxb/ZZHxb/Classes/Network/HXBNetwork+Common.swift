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
    
    /// 检查银行卡号
    static func checkBankNo(params: HXBRequestParam?, configRequstClosure: HXBRequestConfigClosrue? = nil, completionClosure: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.checkcardbin, params: params, method: .post, configRequstClosure: configRequstClosure, completionClosure: completionClosure)
    }
    
    /// 用户获取绑定银行卡信息
    static func bandCardInfo(configRequstClosure: HXBRequestConfigClosrue? = nil, completionClosure: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.bandcard, method: .get, configRequstClosure: configRequstClosure, completionClosure: completionClosure)
    }
}
