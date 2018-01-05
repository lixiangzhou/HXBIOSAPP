//
//  HXBSizeConfig.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/29.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

/// 以750 * 1334 为基准计算，宽度适配
func adaptDecimal(_ num: CGFloat) -> CGFloat {
    return UIScreen.zz_width * num / 375
}

fileprivate let isIPhoneX = UIScreen.zz_height == 812 && UIScreen.zz_width == 375

// MARK: - Padding
extension hxb {
    
    struct size {
        /// 距离屏幕两边的间距 【15】
        static let edgeScreen: CGFloat = 15
        
        /// 两个区域之间的间距 【10】
        static let view2View: CGFloat = 10
        
        /// 一级页面距离底部的距离 【50】
        static let bottom: CGFloat = 50
        
        /// 宽按钮距离屏幕边界的距离 【20】
        static let wideButtonEdgeScreen: CGFloat = 20
        
        /// 宽按钮高度 【41】
        static let wideButtonHeight: CGFloat = 41
        
        /// 宽按钮圆角 【4】
        static let wideButtonCornerRadius: CGFloat = 4
        
        /// 一般按钮的宽 【85】
        static let normalButtonWidth: CGFloat = 85
        
        /// 一般按钮的高 【30】
        static let normalButtonHeight: CGFloat = 30
        
        /// 一般按钮的圆角 【2】
        static let normalButtonCornerRadius: CGFloat = 2
        
        /// 分割线线高 【0.5】
        static let sepLineHeight: CGFloat = 0.5
        
        /// HXBInputFieldView 常用高度
        static let fieldCommonHeight: CGFloat = 60
        
        /// 导航栏高度 【iPhone X：88、其他：64】
        static let navigationHeight: CGFloat = isIPhoneX ? 88 : 64
        
        /// 状态栏高度 【iPhone X：44、其他：20】
        static let statusBarHeight: CGFloat = isIPhoneX ? 44 : 20
        
        /// 状态栏额外高度 【iPhone X：24，其他：0】
        static let topAddtionHeight: CGFloat = isIPhoneX ? 24 : 0
        
        /// 底部额外高度 【iPhone X：34，其他：0】
        static let bottomAddtionHeight: CGFloat = isIPhoneX ? 34 : 0
        /// 隐藏导航栏时距离顶部的距离
        //        static let hideNavagionBar2TopHeight: CGFloat = 0//UIScreen.zz_width == 812 ? 44 : 20
        
        /// 手机号长度 【11】
        static let phoneLength = 11
        
        /// HUD 的 cornerRadius 【5】
        static let hudCornerRadius: CGFloat = 5
    }
}
