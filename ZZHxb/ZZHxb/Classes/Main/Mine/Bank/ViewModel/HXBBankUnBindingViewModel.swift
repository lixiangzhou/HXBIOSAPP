//
//  HXBBankUnBindingViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/27.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import SwiftyJSON

class HXBBankUnBindingViewModel: HXBViewModel {
    var bankModel: HXBBankCardBinModel!
    
    var bankImage: UIImage {
        return UIImage(bankModel.bankCode) ?? UIImage("default_bank")!
    }
    
    var bankName: String {
        return bankModel.bankType
    }
    
    var bankNo: String {
        let showBankNum = "**** **** **** \(bankNoLast4)"
        return showBankNum
    }
    
    var bankNoLast4: String {
        return bankModel.cardId.zz_substring(range: NSRange(location: bankModel.cardId.count - 4, length: 4))
    }
    
    var userName: String {
        return bankModel.name.zz_replace(start: 0, length: bankModel.name.count - 1, with: "*")
    }
    
    
    func validate(idNo: String, pwd: String) -> Bool {
        if idNo.count == 0 {
            HXBHUD.show(toast: "身份证号不能为空")
            return false
        }
        
        if idNo.count != 18 {
            HXBHUD.show(toast: "身份证号输入有误")
            return false
        }
        
        if idNo.count == 0 {
            HXBHUD.show(toast: "交易密码不能为空")
            return false
        }
        
        if pwd.count != 6 {
            HXBHUD.show(toast: "交易密码为6位数字")
            return false
        }
        return true
    }
    
    /// 解绑银行卡 【是否成功，是否push，提示消息】
    func unBind(param: HXBRequestParam, completion: @escaping (Bool, Bool, String) -> ()) {
        HXBNetwork.unBindBankNo(params: param, configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            if isSuccess {
                let json = JSON(requestApi.responseObject!)
                if json.isSuccess {
                    completion(true, true, json.message)
                } else {
                    if json.statusCode == hxb.code.unbindFail {
                        completion(false, true, json.message)
                    } else {
                        requestApi.show(toast: json.message)
                        completion(false, false, json.message)
                    }
                }
            } else {
                completion(false, false, "")
            }
        }
    }
}
