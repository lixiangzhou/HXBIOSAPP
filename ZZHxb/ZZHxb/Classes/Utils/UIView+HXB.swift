//
//  UIView+HXB.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 生成一条线
    ///
    /// - Parameter color: 线的颜色
    /// - Returns: UIView 线
    static func sepLine(color: UIColor = hxb.color.sepLine) -> UIView {
        let sep = UIView()
        sep.backgroundColor = color
        return sep
    }
}
