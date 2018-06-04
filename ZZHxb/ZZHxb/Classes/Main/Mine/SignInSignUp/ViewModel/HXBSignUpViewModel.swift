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
    ///   - completion: 完成回调
    func checkMobile(_ mobile: String) {
        HXBNetwork.checkMobile(mobile, configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
            requestApi.hudShowProgressType = .none
        }) { isSuccess, requestApi in
            if isSuccess {
                let json = JSON(requestApi.responseObject!)
                if json.isSuccess {
                } else if json.statusCode == hxb.code.formProcessFailed {
                    requestApi.show(toast: "请输入正确的手机号")
                } else {
                    self.show(toast: json.message, canShow: true, requestApi: requestApi)
                }
            } else {
                requestApi.show(toast: "该手机号已注册")
            }
        }
    }
    
    /// 获取图形验证码
    ///
    /// - Parameter completion: 完成回调
    func getCaptcha(completion: @escaping (Bool, Data?) -> Void) {
        HXBNetwork.getCaptcha { isSuccess, requestApi in
            completion(isSuccess, requestApi.responseData)
        }
    }
    
    /// 获取验证码
    ///
    /// - Parameters:
    ///   - captcha: 验证码
    ///   - completion: 完成回调
    func validateCaptcha(_ captcha: String, completion: @escaping (Bool) -> Void) {
        HXBNetwork.validateCaptcha(captcha, configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, _ in
            completion(isSuccess)
        }
    }
    
    /// 获取短信验证码
    ///
    /// - Parameters:
    ///   - phone: 手机号
    ///   - captcha: 验证码
    ///   - completion: 完成回调
    func getSmsCode(phone: String, captcha: String, completion: @escaping HXBCommonCompletion) {
        HXBNetwork.sendVerifyCode(params: ["captcha": captcha, "action": "signup", "mobile": phone], configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
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
    ///   - completion: 完成回调
    func signup(mobile: String, smsCode: String, password: String, inviteCode: String?, completion: @escaping HXBCommonCompletion) {
        HXBNetwork.signup(mobile: mobile, smsCode: smsCode, password: password, inviteCode: inviteCode, configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, errorToast: "注册失败",completion: completion)
        }
    }
    
    /// 登录
    ///
    /// - Parameters:
    ///   - mobile: 手机号
    ///   - password: 密码
    ///   - captcha: 验证码
    ///   - completion: 完成回调 Bool 是否完成, Bool 是否需要图验
    func signin(mobile: String, password: String, captcha: String?, completion: @escaping (Bool, Bool) -> Void) {
        HXBNetwork.signin(mobile: mobile, password: password, captcha: captcha, configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            if isSuccess {
                let json = JSON(requestApi.responseObject!)
                if json.isSuccess {
                    completion(true, false)
                } else if json.statusCode == hxb.code.captchaCantEmpty {
                    completion(false, true)
                } else {
                    self.show(toast: json.message, canShow: true, requestApi: requestApi)
                    completion(false, false)
                }
            } else {
                requestApi.show(toast: "登录失败")
                completion(false, false)
            }
        }
    }

    /// 检查手机号
    func checkExistMobile(_ mobile: String) {
        HXBNetwork.checkMobile(mobile, configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            if isSuccess {
                let json = JSON(requestApi.responseObject!)
                if json.statusCode == hxb.code.commonError {
                    let msg = json.message == "手机号码已存在" ? "该手机号已注册" : json.message
                    requestApi.show(toast: msg)
                }
            }
        }
    }
}

extension HXBSignUpViewModel {
    
}
