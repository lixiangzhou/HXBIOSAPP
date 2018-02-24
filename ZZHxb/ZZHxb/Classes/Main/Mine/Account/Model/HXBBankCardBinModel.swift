//
//  HXBBankCardBinModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBBankCardBinModel: HXBModel {
    /// 卡类型（debit：储蓄卡 credit：信用卡）
    var cardType: String = ""
    
    /// 银行编码
    var bankCode: String = ""
    
    /// 银行名称
    var bankName: String = ""
    
    /// 银行提现限额
    var quota: String = ""
    
    /// 是否是信用卡： true: 信用卡, false： 不是信用卡
    var creditCard: Bool = false
    
    /// 是否允许解绑
    var enableUnbind: Bool = false
    
    /// 解绑的原因
    var enableUnbindReason: String = ""
    
    /// 银行名称
    var bankType: String = ""
    
    /// 银行卡号
    var cardId: String = ""
    
    /// 所属银行城市
    var city: String = ""
    
    /// 是非是默认银行卡
    var defaultBank: Bool = false
    
    /// 存款地点
    var deposit: String = ""
    
    var lianlianpayEnabled: Bool = false
    
    /// 银行卡预留手机号
    var mobile: String = ""
    
    /// 用户姓名
    var name: String = ""
    
    /// 银行卡状态,参加数据字段，银行卡部分
    var status: String =  ""
    
    /// 用户卡id
    var userBankId: Int = 0
    
    /// 用户id
    var userId: Int = 0
    
    /// 提现预计到帐时间文本
    var bankArriveTimeText: String = ""
    
    /// 单笔限额
    var single: String = ""
    
    /// 单日限额
    var day: String = ""
}
