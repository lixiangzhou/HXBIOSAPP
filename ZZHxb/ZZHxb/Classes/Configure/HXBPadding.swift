//
//  HXBPadding.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/13.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

/// 以750 * 1334 为基准计算
func adaptDecimal(_ num: CGFloat) -> CGFloat {
    return UIScreen.zz_width * num / 750
}

// MARK: - Padding
extension hxb {
    struct padding {
        // 距离屏幕两边的间距 【15】
        static let edgeScreen: CGFloat = adaptDecimal(15)
        
        // 两个区域之间的间距 【10】
        static let view2View: CGFloat = adaptDecimal(10)
        
        /// 一级页面距离底部的距离 【50】
        static let bottom: CGFloat = adaptDecimal(50)
        
        /// 宽按钮距离屏幕边界的距离 【20】
        static let wideButtonEdgeScreen: CGFloat = adaptDecimal(20)
        
        /// 宽按钮高度 【41】
        static let wideButton: CGFloat = adaptDecimal(41)
        
        /// 宽按钮圆角 【4】
        static let wideButtonCornerRadius: CGFloat = adaptDecimal(4)
        
        /// 一般按钮的宽 【85】
        static let wormalButtonWidth: CGFloat = adaptDecimal(85)
        
        /// 一般按钮的高 【30】
        static let wormalButtonHeight: CGFloat = adaptDecimal(30)
        
        /// 一般按钮的圆角 【2】
        static let wormalButtonCornerRadius: CGFloat = adaptDecimal(2)

    }
}

