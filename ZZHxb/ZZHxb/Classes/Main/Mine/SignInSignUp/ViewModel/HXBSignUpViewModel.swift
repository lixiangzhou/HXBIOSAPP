//
//  HXBSignUpViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/3.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import SwiftyJSON

class HXBSignUpViewModel: HXBViewModel {
    func checkMobile(_ mobile: String, completion: @escaping (Bool, String?) -> Void) {
        HXBNetwork.checkMobile(mobile) { (isSuccess, requestApi) in
            if isSuccess {
                let json = JSON(requestApi.responseObject!)
                if json.statusCode == hxb.code.success {
                    completion(true, nil)
                } else if json.statusCode == hxb.code.formProcessFailed {
                    completion(false, "请输入正确的手机号")
                } else {
                    completion(false, json.message)
                }
            } else {
                completion(false, "该手机号已注册")
            }
        }
    }
    
    func getCaptcha(completion: @escaping (Bool, Data?) -> Void) {
        HXBNetwork.getCaptcha { (isSuccess, requestApi) in
            completion(isSuccess, requestApi.responseData)
        }
    }
}
