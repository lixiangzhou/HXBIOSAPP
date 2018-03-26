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
        var showId = ""
        showId.append(String(idNo[idNo.startIndex..<idNo.index(after: idNo.startIndex)]))
        for _ in 1..<idNo.count - 1 {
            showId.append("*")
        }
        showId.append(String(idNo[idNo.index(before: idNo.endIndex)..<idNo.endIndex]))
        return showId
    }
    
    private var realName: String? {
        let realName = HXBAccountViewModel.shared.account.userInfo.realName
        var showName = ""
        for _ in 0..<realName.count - 1 {
            showName.append("*")
        }
        showName.append(String(realName[realName.index(before: realName.endIndex)..<realName.endIndex]))
        return showName
    }
}
