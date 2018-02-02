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

class HXBAccountMainCellViewModel: HXBViewModel {
    var title: String?
//    var rightAccessoryString: String?
//    var image: UIImage?
    
    var titleSignal: SignalProducer<NSAttributedString, NoError>?
    var rightAccessoryStringSignal: SignalProducer<NSAttributedString, NoError>?
    
    init(title: String?) {
        self.title = title
    }
}
