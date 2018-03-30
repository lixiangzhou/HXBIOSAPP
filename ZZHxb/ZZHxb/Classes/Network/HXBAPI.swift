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
    /// 校验手机号 【/checkExistMobile】
    static let check_exist_mobile = "/checkExistMobile"
}

// MARK: - 账户
extension hxb.api {
    /// 账户内数据总览 【/account】
    static let account = "/account"
    
    /// 开通存管账户 【/user/escrow】
    static let open_depository = "/user/escrow"
    
    /// 校验身份证和短信接口 【/account/checkIdentitySms】
    static let check_identity_sms = "/account/checkIdentitySms"
}


// MARK: - 银行卡
extension hxb.api {
    
    /// 银行卡列表 【/banklist】
    static let banklist = "/banklist"
    /// 银行卡校验 【/user/checkCardBin】
    static let checkcardbin = "/user/checkCardBin"
    /// 用户获取绑定银行卡信息
    static let bankcard = "/account/bankcard"
    /// 解绑银行卡
    static let bankcard_unbind = "/account/bankcard/unbind"
    /// 绑定银行卡
    static let bindcard = "/account/bindcard"
}


// MARK: - 协议
extension hxb.api {
    
    /// 《红小宝平台授权协议》 【/agreement/authorize】
    static let authorize = HXBNetworkConfig.shared.baseUrl + "/agreement/authorize"
    
    /// 《恒丰银行股份有限公司杭州分行网络交易资金账户三方协议》【/agreement/thirdpart】
    static let thirdpard = HXBNetworkConfig.shared.baseUrl + "/agreement/thirdpart"
}

// MARK: - H5
extension hxb.api {
    /// 风险评测 【https://m.hoomxb.com/riskvail】
    static let risk_assessment = "https://m.hoomxb.com/riskvail"
}
