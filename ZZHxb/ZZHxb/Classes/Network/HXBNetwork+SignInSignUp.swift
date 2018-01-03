//
//  HXBNetwork+SignInSignUp.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/3.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

extension HXBNetwork {
    /// 检查手机号
    static func checkMobile(_ mobile: String, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.check_mobile, params: ["mobile": mobile], method: .post, completionBlock: completion)
    }
    
    static func getCaptcha(completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.captcha, responseSerializeType: .data, completionBlock: completion)
    }
    
    static func validateCaptcha(_ captcha: String, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.check_captcha, completionBlock: completion)
    }
}
