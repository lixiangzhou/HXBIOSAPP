//
//  HXBPadding.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/13.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

/// 以750 * 1334 为基准计算，宽度适配
func adaptDecimal(_ num: CGFloat) -> CGFloat {
    return UIScreen.zz_width * num / 375
}

// MARK: - Padding
extension hxb {
    struct size {
        /// 距离屏幕两边的间距 【15】
        static let edgeScreen: CGFloat = adaptDecimal(15)
        
        /// 两个区域之间的间距 【10】
        static let view2View: CGFloat = adaptDecimal(10)
        
        /// 一级页面距离底部的距离 【50】
        static let bottom: CGFloat = adaptDecimal(50)
        
        /// 宽按钮距离屏幕边界的距离 【20】
        static let wideButtonEdgeScreen: CGFloat = adaptDecimal(20)
        
        /// 宽按钮高度 【41】
        static let wideButtonHeight: CGFloat = adaptDecimal(41)
        
        /// 宽按钮圆角 【4】
        static let wideButtonCornerRadius: CGFloat = adaptDecimal(4)
        
        /// 一般按钮的宽 【85】
        static let normalButtonWidth: CGFloat = adaptDecimal(85)
        
        /// 一般按钮的高 【30】
        static let normalButtonHeight: CGFloat = adaptDecimal(30)
        
        /// 一般按钮的圆角 【2】
        static let normalButtonCornerRadius: CGFloat = adaptDecimal(2)
        
        /// 分割线线高 【0.5】
        static let sepLineHeight: CGFloat = 0.5
        
        /// 导航栏高度 【iPhone X：88、其他：64】
        static let navigationHeight: CGFloat = UIScreen.zz_width == 812 ? 88 : 64
        
        /// 状态栏高度 【iPhone X：44、其他：20】
        static let statusBarHeight: CGFloat = UIScreen.zz_width == 812 ? 44 : 20
        
        /// 隐藏导航栏时距离顶部的距离
//        static let hideNavagionBar2TopHeight: CGFloat = 0//UIScreen.zz_width == 812 ? 44 : 20
    }
}

