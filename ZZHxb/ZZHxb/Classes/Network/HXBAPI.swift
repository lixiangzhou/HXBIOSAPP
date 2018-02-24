//
//  HXBAPI.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation

extension hxb {
    struct api {
        /// 发送手机短信验证码、语音验证码 【/verifycode/send】
        static let verifyCode = "/verifycode/send"
        
        /// 获取token 【/token】
        static let token = "/token"
    }
}

// 用户
extension hxb.api {
    /// 获取图验 【/captcha】
    static let captcha = "/captcha"
    /// 校验图片验证码 【/checkCaptcha】
    static let check_captcha = "/checkCaptcha"
    /// 校验手机号 【/checkMobile】
    static let check_mobile = "/checkMobile"
    /// 用户注册接口 【/user/signup】
    static let signup = "/user/signup"
    /// 登录 【/user/login】
    static let signin = "/user/login"
    /// 登出 【/logout】
    static let signout = "/logout"
    /// 获取用户信息 【/user/info】
    static let userinfo = "/user/info"
}

// MARK: - 账户
extension hxb.api {
    /// 账户内数据总览 【/account】
    static let account = "/account"
    
}

extension hxb.api {
    
    /// 银行卡列表 【/banklist】
    static let banklist = "/banklist"
    /// 银行卡校验 【/user/checkCardBin】
    static let checkcardbin = "/user/checkCardBin"
    /// 用户获取绑定银行卡信息
    static let bandcard = "/account/bankcard"
}
