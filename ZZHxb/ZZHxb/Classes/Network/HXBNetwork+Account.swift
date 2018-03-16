//
//  HXBNetwork+Account.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/18.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation

extension HXBNetwork {
    
    /// 获取账户内数据
    static func getAccountData(completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.account, completionClosure: completion)
    }
    
    /// 更新用户信息
    static func updateUserInfo(completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.userinfo, completionClosure: completion)
    }
    
    /// 银行列表
    static func getBankList(configRequstClosure: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.banklist, configRequstClosure: configRequstClosure, completionClosure: completion)
    }
    
    /// 开户
    static func openDepository(params: HXBRequestParam, configRequstClosure: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.open_depository, params: params, method: .post, configRequstClosure: configRequstClosure, completionClosure: completion)
    }
}
