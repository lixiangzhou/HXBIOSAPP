//
//  HXBAccountMainViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountMainViewModel: HXBViewModel {
    var dataSource: [[HXBAccountMainCellViewModel]]
    override init() {
        dataSource = [
            [HXBAccountMainCellViewModel(title: "恒丰银行存管账户", rightAccessoryString: nil),
             HXBAccountMainCellViewModel(title: "银行卡", rightAccessoryString: nil)],
            
            [HXBAccountMainCellViewModel(title: "风险评测", rightAccessoryString: nil),
             HXBAccountMainCellViewModel(title: "恒丰银行存管账户", rightAccessoryString: nil),
             HXBAccountMainCellViewModel(title: "恒丰银行存管账户", rightAccessoryString: nil)]
        ]
        super.init()
    }
}
