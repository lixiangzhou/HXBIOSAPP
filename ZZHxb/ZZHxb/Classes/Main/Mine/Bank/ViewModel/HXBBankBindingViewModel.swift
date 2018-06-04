//
//  HXBBankBindingViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/27.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import SwiftyJSON

class HXBBankBindingViewModel: HXBViewModel {
    /// 持卡人信号
    var cardHolderSignal: SignalProducer<String, NoError>!
    /// 银行卡号信号
    var bankNoSignal: SignalProducer<String, NoError>!
    /// 检查银行卡号是否正确
    let (bankCardSignal, bankCardObserver) = Signal<HXBBankCardBinModel, NoError>.pipe()
    
    /// 银行卡 Model
    fileprivate var bankModel: HXBBankCardBinModel!
    
    override init() {
        super.init()
        
        cardHolderSignal = HXBAccountViewModel.shared.account.userInfo.reactive.producer(forKeyPath: "realName").map { "持卡人：\($0 as? String ?? "")" }
        
        bankNoSignal = HXBAccountViewModel.shared.account.userInfo.reactive.producer(forKeyPath: "idNo").map { value in
            let bankNo = value as? String ?? ""
            return bankNo.zz_replace(start: 1, length: bankNo.count - 2, with: "*") }
    }
    
    /// 检查银行卡号
    func checkBankNo(_ bankNo: String, completion: (() -> ())? = nil) {
        HXBNetwork.checkBankNo(params: ["bankCard": bankNo], configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                self.bankModel = nil
                if isSuccess {
                    if let data = requestApi.responseObject!["data"] as? HXBResponseObject {
                        let bankCardModel = HXBBankCardBinModel.deserialize(from: data)!
                        self.bankModel = bankCardModel
                        self.bankCardObserver.send(value: bankCardModel)
                    } else {
                        self.bankCardObserver.send(value: HXBBankCardBinModel())
                    }
                } else {
                    self.bankCardObserver.send(value: HXBBankCardBinModel())
                }
                completion?()
            })
        }
    }
    
    func bindCard(bankNo: String, mobile: String, completion: @escaping (Bool) -> ()) {
        if let bankModel = bankModel {
            let param = ["bankCard": bankNo,
                         "bankReservedMobile": mobile,
                         "bankCode": bankModel.bankCode]
            HXBNetwork.bindBankNo(params: param, configRequstClosure: { requestApi in
                requestApi.hudDelegate = self
            }, completionClosure: { isSuccess, requestApi in
                if isSuccess {
                    let json = JSON(requestApi.responseObject!)
                    if json.isSuccess {
                        completion(true)
                    } else {
                        if json.statusCode == hxb.code.openCountOut {
                            HXBAlertController.phoneCall(title: "", message: "您今日绑卡错误次数已超限，请明日再试。如有疑问可联系客服 \n\(hxb.string.servicePhone)", right: "联系客服", isAsyncMain: true)
                        }
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            })
            
        } else {
            checkBankNo(bankNo) {
                self.bindCard(bankNo: bankNo, mobile: mobile, completion: completion)
            }
        }
    }
    
}
