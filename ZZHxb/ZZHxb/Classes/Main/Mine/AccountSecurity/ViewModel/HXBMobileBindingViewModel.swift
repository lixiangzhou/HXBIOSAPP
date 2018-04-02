//
//  HXBMobileBindingViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/30.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class HXBMobileBindingViewModel: HXBViewModel {
    var timerSignal: Signal<Int, NoError>! {
        return timerCountingTool.timerSignal
    }
    fileprivate let timerCountingTool = HXBTimerCountingTool()
    fileprivate var captcha: String?
    

    
    @objc func getCode(mobile: String) {
        timerCountingTool.startTimer()
        
        HXBNetwork.checkMobile(mobile) { isSuccess, requestApi in
            if isSuccess {
                HXBCaptchaValidateView.show(comfirmClosure: { captcha in
                    if captcha != nil {
                        let params = [
                            "mobile": mobile,
                            "captcha": captcha!,
                            "action": "newmobile"
                        ]
                        HXBNetwork.sendVerifyCode(params: params, configRequstClosure: { requestApi in
                            requestApi.hudDelegate = self
                        }, completionClosure: { isSuccess, requestApi in
                            if isSuccess {
                                self.captcha = captcha
                            }
                        })
                    }
                })
            }
        }
    }
    
    func modifyMobile(_ mobile: String, code: String, completion: @escaping (Bool) -> ()) {
        if self.captcha == nil {
            show(toast: "请输入正确的短信验证码", type: .view)
            completion(false)
            return
        }
        let param = [
            "action": "newmobile",
            "mobile": mobile,
            "newsmscode": code,
            "captcha": captcha!
        ]
        
        HXBNetwork.modifyMobile(params: param, configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: { isSuccess in
                completion(isSuccess)
            })
        }
    }
}
