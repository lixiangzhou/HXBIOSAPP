//
//  HXBMineCellModel.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBMineCellGroupModel {
    var groupName: String!
    var groupModels: [HXBMineCellModel]!
    
    var groupHeight: CGFloat {
        return showGroupName ? 50 : 0
    }
    
    var showGroupName: Bool {
        return groupName.count > 0
    }
    
    init(groupName: String, groupModels: [HXBMineCellModel]) {
        self.groupName = groupName
        self.groupModels = groupModels
    }
}

class HXBMineCellModel {
    var title: String?
    var rightAccessoryString: String?
    
    init(title: String?, rightAccessoryString: String?) {
        self.title = title
        self.rightAccessoryString = rightAccessoryString
    }
}
