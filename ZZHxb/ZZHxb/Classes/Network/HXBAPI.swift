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
    /// 用户注册接口
    static let signup = "/user/signup"
}

extension hxb.api {
    /// 账户内数据总览 【/account】
    static let account = "/account"
}
