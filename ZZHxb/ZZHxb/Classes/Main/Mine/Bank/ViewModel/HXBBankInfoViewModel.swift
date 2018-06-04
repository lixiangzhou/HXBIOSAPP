//
//  HXBBankInfoViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/26.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import HandyJSON
import SwiftyJSON

class HXBBankInfoViewModel: HXBViewModel {
    let (bankInfoSignal, bankInfoObserver) = Signal<HXBBankCardBinModel, NoError>.pipe()
    var bankModel: HXBBankCardBinModel!
    
    override init() {
        super.init()
        
        getBankInfo()
    }
    
    var enableUnBind: Bool {
        if let bankModel = bankModel {
            return bankModel.enableUnbind
        }
        return false
    }
    
    var enableUnBindReason: String {
        if let bankModel = bankModel {
            return bankModel.enableUnbindReason
        }
        return ""
    }
    
    private func getBankInfo() {
        HXBNetwork.bandCardInfo { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, showToast: false, completion: { isSuccess in
                if isSuccess {
                    if let data = requestApi.responseObject?["data"] as? HXBResponseObject {
                        let bankCardModel = HXBBankCardBinModel.deserialize(from: data)!
                        self.bankModel = bankCardModel
                        self.bankInfoObserver.send(value: bankCardModel)
                    } else {
                        self.bankModel = nil
                        self.bankInfoObserver.send(value: HXBBankCardBinModel())
                    }
                } else {
                    self.bankModel = nil
                    self.bankInfoObserver.send(value: HXBBankCardBinModel())
                }
            })
        }
    }
    
    func formatBankNum(_ bankNum: String, limitWidth: CGFloat) -> NSAttributedString {
        let last = bankNum.zz_substring(range: NSRange(location: bankNum.count - 4, length: 4))
        let showBankNum = "**** **** **** \(last)"
        let width = showBankNum.zz_size(withLimitWidth: limitWidth, fontSize: 24).width
        let space = floor(limitWidth - width) / CGFloat(showBankNum.count - 1)
        return NSAttributedString(string: showBankNum, attributes: [NSAttributedStringKey.kern: space])
    }
}
