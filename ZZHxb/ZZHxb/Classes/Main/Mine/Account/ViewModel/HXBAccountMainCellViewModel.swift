//
//  HXBAccountMainCellViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountMainCellViewModel: HXBViewModel {
    var title: String?
    var rightAccessoryString: String?
    
    init(title: String?, rightAccessoryString: String?) {
        self.title = title
        self.rightAccessoryString = rightAccessoryString
    }
}
