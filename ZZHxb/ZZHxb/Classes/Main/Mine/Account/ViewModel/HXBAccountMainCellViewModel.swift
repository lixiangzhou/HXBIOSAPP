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
    var rightAccessoryString: String?
    var imageName: String?
    
    var rightProducer: SignalProducer<NSAttributedString, NoError>?
    
    init(title: String?, rightAccessoryString: String?, imageName: String?) {
        self.title = title
        self.rightAccessoryString = rightAccessoryString
        self.imageName = imageName
        
        
    }
}
