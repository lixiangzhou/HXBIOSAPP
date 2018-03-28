//
//  HXBNetwork+Bank.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/27.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

extension HXBNetwork {
    /// 银行列表
    static func getBankList(configRequstClosure: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.banklist, configRequstClosure: configRequstClosure, completionClosure: completion)
    }
    
    /// 检查银行卡号
    static func checkBankNo(params: HXBRequestParam?, configRequstClosure: HXBRequestConfigClosrue? = nil, completionClosure: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.checkcardbin, params: params, method: .post, configRequstClosure: configRequstClosure, completionClosure: completionClosure)
    }
    
    /// 用户获取绑定银行卡信息
    static func bandCardInfo(configRequstClosure: HXBRequestConfigClosrue? = nil, completionClosure: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.bankcard, method: .get, configRequstClosure: configRequstClosure, completionClosure: completionClosure)
    }
    
    /// 解绑银行卡号
    static func unBindBankNo(params: HXBRequestParam?, configRequstClosure: HXBRequestConfigClosrue? = nil, completionClosure: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.bankcard_unbind, params: params, method: .post, configRequstClosure: configRequstClosure, completionClosure: completionClosure)
    }
    
    /// 绑定银行卡号
    static func bindBankNo(params: HXBRequestParam?, configRequstClosure: HXBRequestConfigClosrue? = nil, completionClosure: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.bindcard, params: params, method: .post, configRequstClosure: configRequstClosure, completionClosure: completionClosure)
    }
}
