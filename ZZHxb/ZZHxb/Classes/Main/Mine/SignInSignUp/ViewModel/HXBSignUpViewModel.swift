//
//  HXBSignUpViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/3.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import SwiftyJSON

class HXBSignUpViewModel: HXBViewModel {
    
    /// 检测手机号
    ///
    /// - Parameters:
    ///   - mobile: 手机号
    ///   - completion: 完成回调 Bool 是否完成, String toast
    func checkMobile(_ mobile: String, completion: @escaping (Bool, String?) -> Void) {
        HXBNetwork.checkMobile(mobile) { (isSuccess, requestApi) in
            if isSuccess {
                let json = JSON(requestApi.responseObject!)
                if json.isSuccess {
                    completion(true, nil)
                } else if json.statusCode == hxb.code.formProcessFailed {
                    completion(false, "请输入正确的手机号")
                } else {
                    completion(false, json.message)
                }
            } else {
                completion(false, "该手机号已注册")
            }
        }
    }
    
    /// 获取图形验证码
    ///
    /// - Parameter completion: 完成回调 Bool 是否完成, Data 图像数据
    func getCaptcha(completion: @escaping (Bool, Data?) -> Void) {
        HXBNetwork.getCaptcha { (isSuccess, requestApi) in
            completion(isSuccess, requestApi.responseData)
        }
    }
    
    /// 获取验证码
    ///
    /// - Parameters:
    ///   - captcha: 验证码
    ///   - completion: 完成回调 Bool 是否完成
    func validateCaptcha(_ captcha: String, completion: @escaping (Bool) -> Void) {
        HXBNetwork.validateCaptcha(captcha) { (isSuccess, requestApi) in
            completion(isSuccess)
        }
    }
    
    /// 获取短信验证码
    ///
    /// - Parameters:
    ///   - phone: 手机号
    ///   - captcha: 验证码
    ///   - completion: 完成回调 Bool 是否完成, String toast
    func getSmsCode(phone: String, captcha: String, completion: @escaping (Bool, String?) -> Void) {
        HXBNetwork.getSmsCode(phone: phone, captcha: captcha) { (isSuccess, requestApi) in
            self.requestResult(isSuccess, requestApi, errorToast: "获取验证码失败", completion: completion)
        }
    }
    
    /// 注册
    ///
    /// - Parameters:
    ///   - mobile: 手机号
    ///   - smsCode: 短信验证码
    ///   - password: 密码
    ///   - inviteCode: 邀请码
    ///   - completion: 完成回调 Bool 是否完成, String toast
    func signup(mobile: String, smsCode: String, password: String, inviteCode: String?, completion: @escaping (Bool, String?) -> Void) {
        HXBNetwork.signup(mobile: mobile, smsCode: smsCode, password: password, inviteCode: inviteCode) { (isSuccess, requestApi) in
            self.requestResult(isSuccess, requestApi, errorToast: "注册失败",completion: completion)
        }
    }
    
    /// 登录
    ///
    /// - Parameters:
    ///   - mobile: 手机号
    ///   - password: 密码
    ///   - captcha: 验证码
    ///   - completion: 完成回调 Bool 是否完成, String toast, Bool 是否需要图验
    func signin(mobile: String, password: String, captcha: String?, completion: @escaping (Bool, String?, Bool) -> Void) {
        HXBNetwork.signin(mobile: mobile, password: password, captcha: captcha) { (isSuccess, requestApi) in
            if isSuccess {
                let json = JSON(requestApi.responseObject!)
                if json.isSuccess {
                    completion(true, nil, false)
                } else if json.statusCode == hxb.code.captchaCantEmpty {
                    completion(false, nil, true)
                } else {
                    completion(false, json.message, false)
                }
            } else {
                completion(false, "登录失败", false)
            }
        }
    }
}

extension HXBSignUpViewModel {
    
}
