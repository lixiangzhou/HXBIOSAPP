//
//  JSON+HXB.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/3.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    var statusCode: Int {
        return self["status"].intValue
    }
    
    var message: String {
        return self["message"].stringValue
    }
}
