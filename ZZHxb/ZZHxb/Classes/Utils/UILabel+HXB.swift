//
//  UILabel+HXB.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 快速穿件Label
    ///
    /// - parameter text:      text
    /// - parameter fontSize:  字体大小
    /// - parameter textColor: 字体颜色
    ///
    /// - returns: Label
    convenience init(text: String = "", font: UIFont, textColor: UIColor, numOfLines: Int = 0, textAlignment: NSTextAlignment = .left) {
        self.init()
        
        self.font = font
        self.textColor = textColor
        self.text = text
        self.numberOfLines = numOfLines
        self.textAlignment = textAlignment
        
        sizeToFit()
    }
    
}

