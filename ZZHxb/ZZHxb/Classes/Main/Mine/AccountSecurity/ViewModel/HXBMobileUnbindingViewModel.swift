//
//  HXBMobileUnbindingViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/30.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class HXBMobileUnbindingViewModel: HXBViewModel {
    var timerSignal: Signal<Int, NoError>! {
        return timerCountingTool.timerSignal
    }
    fileprivate let timerCountingTool = HXBTimerCountingTool()
    
    var mobileTipAttributeString: NSAttributedString? {
        let attributeText = NSMutableAttributedString()
        attributeText.append(NSAttributedString(string: "短信会发送到手机号为", attributes: [NSAttributedStringKey.font: hxb.font.mainContent]))
        let mobile = HXBAccountViewModel.shared.account.userInfo.mobile
        attributeText.append(NSAttributedString(string: mobile.zz_replace(start: 3, length: 4, with: "*"), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]))
        return attributeText
    }
    
    var nameTipAttributeString: NSAttributedString? {
        let attributeText = NSMutableAttributedString()
        attributeText.append(NSAttributedString(string: "认证姓名：", attributes: [NSAttributedStringKey.font: hxb.font.mainContent]))
        let name = HXBAccountViewModel.shared.account.userInfo.realName
        attributeText.append(NSAttributedString(string: name.zz_replace(start: 0, length: name.count - 1, with: "*"), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]))
        return attributeText
    }
    
    var showIdcard: Bool {
        /// 开通存管就一定有身份证号，否则没有
        return HXBAccountViewModel.shared.hasDepositoryOpen
    }
    
    func checkIdentifySms(idNo: String, code: String, completion: @escaping (Bool) -> ()) {
        HXBNetwork.checkIdentitySms(params: ["action": "oldmobile", "smscode": code, "identity": idNo], configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                completion(isSuccess)
            })
        }
    }
    
    
    @objc func getCode() {
        timerCountingTool.startTimer()
        
        HXBNetwork.sendVerifyCode(params: ["action": "oldmobile"], configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                if !isSuccess {
                    self.timerCountingTool.timerObserver.send(value: 0)
                    self.timerCountingTool.stopTimer()
                }
            })
        }
    }
    
}
