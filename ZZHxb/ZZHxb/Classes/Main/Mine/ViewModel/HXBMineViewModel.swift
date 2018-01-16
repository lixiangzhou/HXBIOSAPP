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
    
    /// 持有总资产
    var holdingTotalAssetsProducer: SignalProducer<String, NoError>
    /// 可用余额
    var availablePointProducer: SignalProducer<String, NoError>
    /// 累计收益
    var earnTotalProducer: SignalProducer<String, NoError>
    
    
    
    override init() {
        dataSource = [
            HXBMineCellGroupModel(groupName: "我的福利", groupModels: [
                HXBMineCellModel(title: "优惠券", rightAccessoryString: nil),
                HXBMineCellModel(title: "邀请好友", rightAccessoryString: nil)
                ]),
            HXBMineCellGroupModel(groupName: "我的资产", groupModels: [
                HXBMineCellModel(title: "红利计划资产", rightAccessoryString: "0.00元"),
                HXBMineCellModel(title: "散标债券资产", rightAccessoryString: "0.00元")
                ]),
            HXBMineCellGroupModel(groupName: "", groupModels: [
                HXBMineCellModel(title: "交易记录", rightAccessoryString: "0.00元"),
                ])
            ]
        
        holdingTotalAssetsProducer = holdingTotalAssetsProperty.map { $0.moneyString }.producer
        availablePointProducer = availablePointProperty.map { $0.moneyString }.producer
        earnTotalProducer = earnTotalProperty.map { $0.moneyString }.producer
    }
    
    
    
    func getAccountData(completion: @escaping (Bool) -> ()) {
        HXBNetwork.getAccountData { (isSuccess, requestApi) in
            self.requestResult(isSuccess, requestApi, errorToast: nil, completion: { (isSuccess, _) in
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
