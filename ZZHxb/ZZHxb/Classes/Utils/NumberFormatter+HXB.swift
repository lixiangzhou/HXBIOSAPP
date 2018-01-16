//
//  NumberFormatter+HXB.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

fileprivate let format: NumberFormatter = {
    let format = NumberFormatter()
    format.usesGroupingSeparator = true
    format.groupingSize = 3
    format.minimumFractionDigits = 2
    format.minimumSignificantDigits = 3
    return format
}()

extension NumberFormatter {
    static func string(withMoney: Int) -> String {
        return format.string(from: NSNumber(value: withMoney))!
    }
}

extension Int {
    var moneyString: String {
        return NumberFormatter.string(withMoney: self)
    }
}
