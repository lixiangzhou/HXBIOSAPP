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
        HXBNetworkManager.request(url: hxb.api.check_mobile, params: ["mobile": mobile], method: .post, completionClosure: completion)
    }
    
    /// 获取图形验证码
    static func getCaptcha(completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.captcha, responseSerializeType: .data, completionClosure: completion)
    }
    
    /// 获取验证码
    static func validateCaptcha(_ captcha: String, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.check_captcha, params: ["captcha": captcha], method: .post, completionClosure: completion)
    }
    
    /// 获取短信验证码
    static func getSmsCode(phone: String, captcha: String, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.verifyCode, params: ["captcha": captcha, "action": "signup", "mobile": phone], method: .post, completionClosure: completion)
    }
}
