//
//  HXBAccountMainCellViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

enum HXBAccountMainCellType: String {
    
    /// 用户名
    case username = ""
    
    
    /// 恒丰银行存管账户
    case depositoryAccount = "恒丰银行存管账户"
    /// 银行卡
    case bank = "银行卡"
    
    
    /// 风险评测
    case risk = "风险评测"
    /// 账户安全
    case accountSecure = "账户安全"
    /// 我的财富顾问
    case advisor = "我的财富顾问"
    /// 关于我们
    case about = "关于我们"
}

class HXBAccountMainCellViewModel: HXBViewModel {
    var title: String
    var type: HXBAccountMainCellType
//    var rightAccessoryString: String?
//    var image: UIImage?
    
    var titleSignal: SignalProducer<NSAttributedString, NoError>?
    var rightAccessoryStringSignal: SignalProducer<NSAttributedString, NoError>?
    
    init(type: HXBAccountMainCellType) {
        self.type = type
        self.title = type.rawValue
    }
}
