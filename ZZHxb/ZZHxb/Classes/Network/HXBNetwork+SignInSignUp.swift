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
    static func checkMobile(_ mobile: String, configProgressAndToast: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.check_mobile, params: ["mobile": mobile], method: .post, configProgressAndToast: configProgressAndToast, completionClosure: completion)
    }
    
    /// 获取图形验证码
    static func getCaptcha(configProgressAndToast: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.captcha, responseSerializeType: .data, configProgressAndToast: configProgressAndToast, completionClosure: completion)
    }
    
    /// 获取验证码
    static func validateCaptcha(_ captcha: String, configProgressAndToast: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.check_captcha, params: ["captcha": captcha], method: .post, configProgressAndToast: configProgressAndToast, completionClosure: completion)
    }
    
    /// 获取短信验证码
    static func getSmsCode(phone: String, captcha: String, configProgressAndToast: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.verifyCode, params: ["captcha": captcha, "action": "signup", "mobile": phone], method: .post, configProgressAndToast: configProgressAndToast, completionClosure: completion)
    }
    
    /// 注册
    static func signup(mobile: String, smsCode: String, password: String, inviteCode: String?, configProgressAndToast: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        var param = ["mobile": mobile, "smscode": smsCode, "password": password]
        if let inviteCode = inviteCode {
            param["inviteCode"] = inviteCode
        }
        HXBNetworkManager.request(url: hxb.api.signup, params: param, method: .post, configProgressAndToast: configProgressAndToast, completionClosure: completion)
    }
    
    /// 登录
    static func signin(mobile: String, password: String, captcha: String?, configProgressAndToast: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        var param = ["mobile": mobile, "password": password]
        if let captcha = captcha {
            param["captcha"] = captcha
        }
        
        HXBNetworkManager.request(url: hxb.api.signin, params: param, method: .post, configProgressAndToast: configProgressAndToast, completionClosure: completion)
    }
    
    /// 登出
    static func signout(configProgressAndToast: HXBRequestConfigClosrue? = nil, completion: @escaping HXBRequestCompletionCallBack) {
        HXBNetworkManager.request(url: hxb.api.signout, method: .post, configProgressAndToast: configProgressAndToast, completionClosure: completion)
    }
}
