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
        
        /// 闪屏 【/splash】
        static let slash = "/splash"
        /// 首页 【/home】
        static let home = "/home"
        
        
        /// 用户信息 【/user/info】
        static let userInfo = "/user/info"
        
        /// 登录 【/user/login】
        static let login = "/user/login"
        /// 注册 【/user/signup】
        static let signup = "/user/signup"
        /// 忘记密码 【/forgot】
        static let forgetPwd = "/forgot"
        /// 校验图片验证码 【/checkCaptcha】
        static let check_captcha = "/checkCaptcha"
        /// 发送短信接口 【/send/smscode】
        static let send_smscode = "/send/smscode"
        /// 校验手机号 【/checkMobile】
        static let check_mobile = "/checkMobile"
        /// 忘记密码校验手机号 【/checkExistMobile】
        static let check_exist_mobile = "/checkExistMobile"
        /// 实名认证 【/user/realname】
        static let realname = "/user/realname"
        /// 风险评测 【/user/riskModifyScore】
        static let risk_modify_score = "/user/riskModifyScore"
        /// 获取理财顾问信息【/account/advisor】
        static let advisor = "/account/advisor"
        /// 账户内数据总览 【/account】
        static let account = "/account"
    }
}
