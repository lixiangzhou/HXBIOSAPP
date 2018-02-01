//
//  HXBUser.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/1.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBUserModel: HXBModel {
    static let shared = HXBUserModel()
    var userAssets = HXBUserAssetsModel()
    var userInfo = HXBUserInfoModel()
}

class HXBUserInfoModel: HXBModel {
    @objc dynamic var unread: String = ""
    
    /// 用户id
    @objc dynamic var userId: String = ""
    
    /// 用户名称
    @objc dynamic var username: String = ""
    
    /// 用户手机
    @objc dynamic var mobile: String = ""
    
    /// 是否绑卡 1：已绑卡， 0：未绑卡
    @objc dynamic var hasBindCard: String = ""
    
    /// 是否实名
    @objc dynamic var isIdPassed: String = ""
    
    /// 是否有交易密码
    @objc dynamic var isCashPasswordPassed: String = ""
    
    /// 是否手机号
    @objc dynamic var isMobilePassed: String = ""
    
    /// 【未使用】
    @objc dynamic var sourceValue: String = ""
    
    /// 【未使用】
    @objc dynamic var hasInvestCode: String = ""
    
    /// 是否安全认证
    @objc dynamic var isAllPassed: String = ""
    
    /// 是否开通存管账户 1：已开通， 0：未开通
    @objc dynamic var isCreateEscrowAcc: String = ""
    
    /// 【未使用】
    @objc dynamic var hasEverInvestLoan: String = ""
    /// 【未使用】
    @objc dynamic var hasRecharge: String = "0"
    
    /// 【未使用】
    @objc dynamic var inviteRole: String = ""
    
    /// 1: 是新手；0: 不是新手
    @objc dynamic var isNewbie: String = ""
    
    /// 【未使用】
    @objc dynamic var inviteUid: String = ""
    
    /// 【未使用】
    @objc dynamic var inviteSerial: String = ""
    
    /// 是否投资过
    @objc dynamic var hasEverInvest: String = ""
    
    /// ip
    @objc dynamic var ip: String = ""
    
    /// 登录时间
    @objc dynamic var loginTime: String = ""
    
    /// 风险评测类型
    @objc dynamic var riskType = ""
    
    /// 最小充值金额
    @objc dynamic var minChargeAmount: Double = 0
    
    /// 最小提现金额
    @objc dynamic var minWithdrawAmount: Double = 0
    
    /// 是否有理财顾问
    @objc dynamic var isDisplayAdvisor: Bool = false
    
    /// 【未使用】
    @objc dynamic var isEmployee: Bool = false
    
    /// 【未使用】
    @objc dynamic var isSales: Bool = false
}

class HXBUserAssetModel: HXBModel {
    /// 累计收益
    @objc dynamic var earnTotal: Double = 0
    
    /// 【未使用】
    @objc dynamic var yesterdayInterest: Double = 0
    
    /// 用户可出借总金额
    @objc dynamic var userRiskAmount: String = ""
    
    /// 用户可购买产品风险类型集合:保守型：[“AA”,”A”,”CONSERVATIVE”];稳健性：[“AA”,”A”, “B”,”CONSERVATIVE”, “PRUDENT”]；激进型：[“D”, “AA”, “A”,”PROACTIVE”, “B”,”C”,”CONSERVATIVE”, “PRUDENT”]
    @objc dynamic var userRisk: [String] = [String]()
    
    /// 红利计划-累计收益
    @objc dynamic var financePlanSumPlanInterest: Double = 0
    
    /// 散标债权-累计收益
    @objc dynamic var lenderEarned: Double = 0
    
    /// 可用余额
    @objc dynamic var availablePoint: Double = 0
    
    /// 【未使用】
    @objc dynamic var userRiskType: String = ""
    
    /// 散标债权-持有资产
    @objc dynamic var lenderPrincipal: Double = 0
    
    /// 红利计划-持有资产
    @objc dynamic var financePlanAssets: Double = 0
    
    /// 总持有本金（包含冻结金额,用于购买时比较）
    @objc dynamic var holdingAmount: Double = 0
    
    /// 总资产
    @objc dynamic var assetsTotal: Double = 0
    
    /// 冻结余额
    @objc dynamic var frozenPoint: Double = 0
    
    /// 持有总资产字段：红利计划持有+散标债券持有
    @objc dynamic var holdingTotalAssets: Double = 0
}
