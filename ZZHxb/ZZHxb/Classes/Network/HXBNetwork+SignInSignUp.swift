//
//  HXBNetwork+SignInSignUp.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/3.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

extension HXBNetwork {
    /// 检查手机号
    static func checkMobile(_ mobile: String, configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        return HXBNetworkManager.rac_request(url: hxb.api.check_mobile, params: ["mobile": mobile], method: .post, configRequstClosure: configRequstClosure)
    }
    
    /// 获取图形验证码
    static func getCaptcha(configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        return HXBNetworkManager.rac_request(url: hxb.api.captcha, responseSerializeType: .data, configRequstClosure: configRequstClosure)
    }
    
    /// 获取验证码
    static func validateCaptcha(_ captcha: String, configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        return HXBNetworkManager.rac_request(url: hxb.api.check_captcha, params: ["captcha": captcha], method: .post, configRequstClosure: configRequstClosure)
    }
    
    /// 注册
    static func signup(mobile: String, smsCode: String, password: String, inviteCode: String?, configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        var param = ["mobile": mobile, "smscode": smsCode, "password": password]
        if let inviteCode = inviteCode {
            param["inviteCode"] = inviteCode
        }
        return HXBNetworkManager.rac_request(url: hxb.api.signup, params: param, method: .post, configRequstClosure: configRequstClosure)
    }
    
    /// 登录
    static func signin(mobile: String, password: String, captcha: String?, configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        var param = ["mobile": mobile, "password": password]
        if let captcha = captcha {
            param["captcha"] = captcha
        }
        
        return HXBNetworkManager.rac_request(url: hxb.api.signin, params: param, method: .post, configRequstClosure: configRequstClosure)
    }
    
    /// 登出
    static func signout(configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        return HXBNetworkManager.rac_request(url: hxb.api.signout, method: .post, configRequstClosure: configRequstClosure)
    }
    
    /// 校验手机号
    static func checkExistMobile(_ mobile: String, configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        return HXBNetworkManager.rac_request(url: hxb.api.check_exist_mobile, params: ["mobile": mobile], method: .post, configRequstClosure: configRequstClosure)
    }
}
