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
import SwiftyJSON

class HXBDepositoryOpenOrModifyViewModel: HXBViewModel {
    /// 检查银行卡号是否正确
    let (bankCardSignal, bankCardObserver) = Signal<HXBBankCardBinModel, NoError>.pipe()
    
    /// 获取银行卡代码
    var bankCode: String?
    
    /// 更新银行卡信息
    let (updateBankInfoSignal, updateBankInfoObserver) = Signal<HXBBankCardBinModel, NoError>.pipe()
    
    override init() {
        super.init()
        
        HXBAccountViewModel.shared.bandCardSignal.startWithValues { [weak self] band in
            if band {
                self?.getBankInfo()
            }
        }
        
    }
    
    func checkBankNo(_ bankNo: String) {
        HXBNetwork.checkBankNo(params: ["bankCard": bankNo], configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                if isSuccess {
                    if let data = requestApi.responseObject!["data"] as? HXBResponseObject {
                        let bankCardModel = HXBBankCardBinModel.deserialize(from: data)!
                        self.bankCode = bankCardModel.bankCode
                        self.bankCardObserver.send(value: bankCardModel)
                    } else {
                        self.bankCode = nil
                        self.bankCardObserver.send(value: HXBBankCardBinModel())
                    }
                } else {
                    self.bankCode = nil
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
        HXBNetwork.bandCardInfo { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, showToast: false, completion: { isSuccess in
                if isSuccess {
                    if let data = requestApi.responseObject?["data"] as? HXBResponseObject {
                        let bankCardModel = HXBBankCardBinModel.deserialize(from: data)!
                        self.bankCode = bankCardModel.bankCode
                        self.updateBankInfoObserver.send(value: bankCardModel)
                    } else {
                        self.bankCode = nil
                        self.updateBankInfoObserver.send(value: HXBBankCardBinModel())
                    }
                } else {
                    self.bankCode = nil
                    self.updateBankInfoObserver.send(value: HXBBankCardBinModel())
                }
            })
        }
    }
    
    /// 开通存管账户
    func openDepository(param: [String: String], entryType: HXBDepositoryEntyType, completion: @escaping (Bool) -> ()) {
        HXBNetwork.openDepository(params: param, configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, errorToast: nil, showToast: false, completion: { isSuccess in
                if isSuccess {
                    let msg = entryType == .open ? "开户成功" : "提交成功"
                    requestApi.show(toast: msg)
                } else {
                    if let respObj = requestApi.responseObject {
                        let json = JSON(respObj)
                        if json.statusCode == hxb.code.openCountOut {
                            HXBAlertController.phoneCall(title: "", message: "您今日开通存管错误次数已超限，请明日再试。如有疑问可联系客服 \(hxb.string.servicePhone)")
                        }
                    }
                }
                completion(isSuccess)
            })
        }
    }
}
