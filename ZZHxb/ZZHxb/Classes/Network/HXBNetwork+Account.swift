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
    
    /// 开户
    static func openDepository(params: HXBRequestParam, configRequstClosure: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.open_depository, params: params, method: .post, configRequstClosure: configRequstClosure, completionClosure: completion)
    }
    
    /// 修改手机号
    static func modifyMobile(params: HXBRequestParam, configRequstClosure: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.modify_mobile, params: params, method: .post, configRequstClosure: configRequstClosure, completionClosure: completion)
    }
}
