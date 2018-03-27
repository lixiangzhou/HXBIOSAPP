//
//  HXBAccountInfoViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/26.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountInfoViewModel: HXBViewModel {
    var dataSource = [HXBAccountInfoModel]()
    override init() {
        super.init()
        
        dataSource.append(HXBAccountInfoModel(type: "真实姓名", value: realName, link: nil))
        dataSource.append(HXBAccountInfoModel(type: "身份证号", value: idNo, link: nil))
        dataSource.append(HXBAccountInfoModel(type: "存管协议", value: "《恒丰银行…协议》", link: hxb.api.thirdpard))
    }
    
    private var idNo: String? {
        let idNo = HXBAccountViewModel.shared.account.userInfo.idNo
        return idNo.zz_replace(start: 1, length: idNo.count - 2, with: "*")
    }
    
    private var realName: String? {
        let realName = HXBAccountViewModel.shared.account.userInfo.realName
        return realName.zz_replace(start: 0, length: realName.count - 1, with: "*")
    }
}
