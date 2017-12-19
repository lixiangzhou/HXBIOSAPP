//
//  HXBMineViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBMineViewModel: HXBViewModel {
    var dataSource = [HXBMineCellGroupModel]()
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
    }
    
    func getAccountData(completion: @escaping (Bool) -> ()) {
        HXBNetwork.getAccountData { (isSuccess, requestApi, responseObj, error) in
            completion(true)
            if isSuccess {
                
            } else {
                
            }
        }
    }
}
