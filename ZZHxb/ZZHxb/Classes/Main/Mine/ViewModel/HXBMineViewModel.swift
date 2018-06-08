//
//  HXBMineViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import HandyJSON
import ReactiveCocoa
import ReactiveSwift
import Result

class HXBMineViewModel: HXBViewModel {
    var dataSource = [HXBMineCellGroupModel]()
    var userAssets = HXBUserAssetsModel()
    /// 持有总资产
    var holdingTotalAssetsProperty = MutableProperty(0)
    /// 可用余额
    var availablePointProperty = MutableProperty(0)
    /// 累计收益
    var earnTotalProperty = MutableProperty(0)
    
    /*
     var iconClick: (() -> ())?
     var bgViewClick: (() -> ())?
     var chargeClick:(() -> ())?
     var withDrawClick:(() -> ())?

     */
    /// 点击我的进入个人账户
    var (accountSignal, accountObserver) = Signal<(), NoError>.pipe()
    /// 点击背景
    var (assetSignal, assetObserver) = Signal<(), NoError>.pipe()
    /// 点击充值
    var (chargeSignal, chargeObserver) = Signal<(), NoError>.pipe()
    /// 点击体现
    var (withdrawSignal, withdrawObserver) = Signal<(), NoError>.pipe()
    
    /// 持有总资产
    var holdingTotalAssetsProducer: SignalProducer<String, NoError>
    /// 可用余额
    var availablePointProducer: SignalProducer<String, NoError>
    /// 累计收益
    var earnTotalProducer: SignalProducer<String, NoError>
    
    /// 刷新列表
    var (reloadDataSignal, reloadDataObserver) = Signal<(), NoError>.pipe()
    
    override init() {
        holdingTotalAssetsProducer = holdingTotalAssetsProperty.map { $0.moneyString }.producer
        availablePointProducer = availablePointProperty.map { $0.moneyString }.producer
        earnTotalProducer = earnTotalProperty.map { $0.moneyString }.producer
        
        super.init()
        
        displayInvite()
    }
    
    private func displayInvite() {
        let group1HasInvite = HXBMineCellGroupModel(groupName: "我的福利", groupModels: [
            HXBMineCellModel(title: "优惠券", rightAccessoryString: nil),
            HXBMineCellModel(title: "邀请好友", rightAccessoryString: nil)
            ])
        let group1NoInvite = HXBMineCellGroupModel(groupName: "我的福利", groupModels: [
            HXBMineCellModel(title: "优惠券", rightAccessoryString: nil)
            ])
        
        let group2 = HXBMineCellGroupModel(groupName: "我的资产", groupModels: [
            HXBMineCellModel(title: "红利计划资产", rightAccessoryString: "0.00元"),
            HXBMineCellModel(title: "散标债券资产", rightAccessoryString: "0.00元")
            ])
        let group3 = HXBMineCellGroupModel(groupName: "", groupModels: [
            HXBMineCellModel(title: "交易记录", rightAccessoryString: "0.00元"),
            ])
        
        HXBAccountViewModel.shared.displayInviteSignal.skipRepeats().startWithValues { [weak self] isDisplay in
            if isDisplay == true {
                self?.dataSource = [group1HasInvite, group2, group3]
            } else {
                self?.dataSource = [group1NoInvite, group2, group3]
            }
            self?.reloadDataObserver.send(value: ())
        }
    }
    
    func getAccountData2() {
        
    }
    
    func getAccountData(completion: @escaping HXBCommonCompletion) {
        HXBNetwork.getAccountData { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                if isSuccess {
                    JSONDeserializer.update(object: &self.userAssets, from: requestApi.responseObject!)
                    self.holdingTotalAssetsProperty.value = self.userAssets.holdingTotalAssets
                    self.availablePointProperty.value = self.userAssets.availablePoint
                    self.earnTotalProperty.value = self.userAssets.earnTotal
                }
                completion(isSuccess)
            })
        }
    }
}
