//
//  HXBUserAssetsModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/15.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import HandyJSON

class HXBUserAssetsModel: HXBModel {
    /// 总资产
    var assetsTotal = 0
    /// 可用优惠券数量
    var availableCouponCount = 0
    /// 可用余额
    var availablePoint = 0
    /// 累计收益
    var earnTotal = 0
    /// 红利计划-持有资产
    var financePlanAssets = 0
    /// 红利计划-累计收益
    var financePlanSumPlanInterest = 0
    /// 冻结余额
    var frozenPoint = 0
    /// 散标债权-累计收益
    var lenderEarned = 0
    /// 散标债权-持有资产
    var lenderPrincipal = 0
    /// 持有总资产
    var holdingTotalAssets = 0
}
