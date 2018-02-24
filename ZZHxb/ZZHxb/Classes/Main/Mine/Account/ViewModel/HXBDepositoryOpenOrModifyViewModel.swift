//
//  HXBDepositoryOpenOrModifyViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import HandyJSON

class HXBDepositoryOpenOrModifyViewModel: HXBViewModel {
    /// 检查银行卡号是否正确
    let (bankCardSignal, bankCardObserver) = Signal<HXBBankCardBinModel, NoError>.pipe()
    
    /// 获取银行卡号
    var bankCodeSignal: SignalProducer<String, NoError>!
    
    /// 更新银行卡信息
    let (updateBankInfoSignal, updateBankInfoObserver) = Signal<HXBBankCardBinModel, NoError>.pipe()
    
    override init() {
        super.init()
        
        HXBAccountViewModel.shared.bandCardSignal.startWithValues { band in
            if band {
                self.getBankInfo()
            }
        }
        
        bankCodeSignal = bankCardSignal.producer.map { $0.bankCode }
    }
    
    func checkBankNo(_ bankNo: String) {
        HXBNetwork.checkBankNo(params: ["bankCard": bankNo], configProgressAndToast: { requestApi in
            requestApi.hudDelegate = self
        }) { (isSuccess, requestApi) in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                if isSuccess {
                    if let data = requestApi.responseObject!["data"] as? HXBResponseObject {
                        let bankCardModel = HXBBankCardBinModel.deserialize(from: data)!
                        self.bankCardObserver.send(value: bankCardModel)
                    } else {
                        self.bankCardObserver.send(value: HXBBankCardBinModel())
                    }
                } else {
                    self.bankCardObserver.send(value: HXBBankCardBinModel())
                }
            })
        }
    }
    
    
    /// 更新存管信息
    func updateDepositoryInfo(completion: @escaping () -> ()) {
        HXBAccountViewModel.shared.updateUserInfoSuccess(completion)
    }
    
    
    /// 获取银行卡号信息
    func getBankInfo() {
        HXBNetwork.bandCardInfo { (isSuccess, requestApi) in
            self.requestResult(isSuccess, requestApi, showToast: false, completion: { isSuccess in
                if isSuccess {
                    // TODO: 没有相关的Doc
                    if let data = requestApi.responseObject?["data"] as? HXBResponseObject {
                        self.updateBankInfoObserver.send(value: HXBBankCardBinModel.deserialize(from: data)!)
                    } else {
                        self.updateBankInfoObserver.send(value: HXBBankCardBinModel())
                    }
                } else {
                    self.updateBankInfoObserver.send(value: HXBBankCardBinModel())
                }
            })
        }
    }
}
