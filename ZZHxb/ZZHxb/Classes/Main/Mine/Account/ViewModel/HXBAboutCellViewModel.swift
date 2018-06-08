//
//  HXBAboutCellViewModel.swift
//  ZZHxb
//
//  Created by lixiangzhou on 2018/6/8.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAboutCellViewModel: HXBViewModel {
    var title: String?
    var titleAccessoryString: String?
    var accessoryTitle: String?
    var action: ((UIViewController) -> Void)?
    
    init(title: String?, titleAccessoryString: String?, accessoryTitle: String?, action: ((UIViewController) -> Void)?) {
        self.title = title
        self.titleAccessoryString = titleAccessoryString
        self.accessoryTitle = accessoryTitle
        self.action = action
        
        super.init()
    }
}
