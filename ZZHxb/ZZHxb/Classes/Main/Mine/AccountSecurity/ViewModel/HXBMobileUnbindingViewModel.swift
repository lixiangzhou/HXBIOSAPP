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
    fileprivate var timer: Timer?
    fileprivate var timerCount = 59
    let (timerSignal, timerObserver) = Signal<Int, NoError>.pipe()
    
    var tipAttributeString: NSAttributedString? {
        let attributeText = NSMutableAttributedString()
        attributeText.append(NSAttributedString(string: "短信会发送到手机号为", attributes: [NSAttributedStringKey.font: hxb.font.mainContent]))
        let mobile = HXBAccountViewModel.shared.account.userInfo.mobile
        attributeText.append(NSAttributedString(string: mobile.zz_replace(start: 3, length: 4, with: "*"), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]))
        return attributeText
    }
    
    func checkIdentifySms(code: String, completion: @escaping (Bool) -> ()) {
        HXBNetwork.checkIdentitySms(params: ["action": "oldmobile", "smscode": code], configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                completion(isSuccess)
            })
        }
    }
    
    @objc func getCode() {
        startTimer()
        
        HXBNetwork.sendVerifyCode(params: ["action": "oldmobile"], configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                if !isSuccess {
                    self.timerObserver.send(value: 0)
                    self.stopTimer()
                }
            })
        }
    }
    
}
extension HXBMobileUnbindingViewModel {
    private func startTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timerCount = 59
        timerObserver.send(value: timerCount)
        timer = Timer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func countDown() {
        timerCount -= 1
        if timerCount <= 0 {
            timerObserver.send(value: 0)
            stopTimer()
        } else {
            timerObserver.send(value: timerCount)
        }
    }
}
