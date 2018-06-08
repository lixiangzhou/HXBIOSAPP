//
//  HXBAboutViewModel.swift
//  ZZHxb
//
//  Created by lixiangzhou on 2018/6/8.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAboutViewModel: HXBViewModel {
    var dataSource = [HXBAboutCellViewModel]()
    override init() {
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "0"
        dataSource = [
            HXBAboutCellViewModel(title: "客服热线", titleAccessoryString: "(工作日9:00-18:00)", accessoryTitle: hxb.string.servicePhone, action: { vc in
                HXBAlertController.phoneCall(title: "红小宝客服电话", message: hxb.string.servicePhone, isAsyncMain: true)
            }),
            HXBAboutCellViewModel(title: "版本", titleAccessoryString: nil, accessoryTitle: version, action: nil),
            HXBAboutCellViewModel(title: "常见问题", titleAccessoryString: nil, accessoryTitle: nil, action: { vc in
                HXBCommonProblemController().pushFrom(controller: vc, animated: true)
            })
        ]
    }
}
