//
//  HXBAccountSecurityModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/29.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

enum HXBAccountSecurityType {
    case phone              // 修改手机号
    case SignInPwd          // 登录密码
    case transactionPwd     // 交易密码
    case gesturePwdSwitch   // 手势密码
    case modifyGesturePwd   // 修改手势密码
}

struct HXBAccountSecurityModel {
    var title: String
    var type: HXBAccountSecurityType
    var switchClosure: ((Bool) -> ())?
}
