//
//  HXBAccountSecurityViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/29.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountSecurityViewModel: HXBViewModel {
    var dataSource = [HXBAccountSecurityModel]()
    var swithClosure: ((Bool) -> ())?
    
    func prepareData() {
        dataSource.removeAll()
        
        dataSource.append(HXBAccountSecurityModel(title: "修改手机号", type: .phone, switchClosure: nil))
        dataSource.append(HXBAccountSecurityModel(title: "登录密码", type: .SignInPwd, switchClosure: nil))
        dataSource.append(HXBAccountSecurityModel(title: "交易密码", type: .transactionPwd, switchClosure: nil))
        dataSource.append(HXBAccountSecurityModel(title: "手势密码", type: .gesturePwdSwitch, switchClosure: { isOn in
            self.swithClosure?(isOn)
        }))
        dataSource.append(HXBAccountSecurityModel(title: "修改手势密码", type: .modifyGesturePwd, switchClosure: nil))
    }
    
    
}
