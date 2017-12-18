//
//  HXBColorFontConfig.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/13.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

// MARK: - Color
struct hxb {
    struct color {
        /// 用于特别需要强调和突出的文字、按钮和icon 【f55151】
        static let mostImport = UIColor(stringHexValue: "f55151")!
        
        /// 用于特别需要强调和突出的颜色填充，颜色值范围：【fe654d ~ ff3d4f】
        ///
        /// - Parameter hex: 16进制颜色值
        /// - Returns: UIColor
        static func importantFill(hex: String) -> UIColor {
            return UIColor(stringHexValue: hex)!
        }
        
        /// 用于重要的文字信息、内容标题 【333333】
        static let important = UIColor(stringHexValue: "333333")!
        
        /// 小面积使用，用于重要链接文字、活动入口 【73adff】
        static let linkActivity = UIColor(stringHexValue: "73adff")!
        
        /// 用于普通级段落信息 【666666】
        static let normal = UIColor(stringHexValue: "666666")!
        
        /// 用于辅助、次要的文字等 【999999】
        static let light = UIColor(stringHexValue: "999999")!
        
        /// 用于色块之间的间隔底色填充 【f5f5f9】
        static let view2ViewFill = UIColor(stringHexValue: "f5f5f9")!
        
        /// 用于分割线 【dddddd】
        static let sepLine = UIColor(stringHexValue: "dddddd")!
        
        /// 白色 【UIColor.white】
        static let white = UIColor.white
        
        /// 背景色 【f5f5f9】
        static let background = UIColor(stringHexValue: "f5f5f9")!
    }
}

// MARK: - Font
extension hxb {
    private static let fontName = "HelveticaNeue"
    struct font {
        /// 用于个人账户也最重要金额文字 【40】
        static let mostImportant = UIFont(name: fontName, size: adaptDecimal(40))!
        
        /// 用于强调性醒目文字 【24】
        static let important = UIFont(name: fontName, size: adaptDecimal(24))!
        
        /// 用于页面主要标题内容 【19】
        static let pageTitle = UIFont(name: fontName, size: adaptDecimal(19))!
        
        /// 用于导航栏标题 【18】
        static let navTitle = UIFont(name: fontName, size: adaptDecimal(18))!
        
        /// 用于导航栏标题(多个标题时) 【17】
        static let navMultiTitle = UIFont(name: fontName, size: adaptDecimal(17))!
        
        /// 用于一级button文字 【16】
        static let firstClass = UIFont(name: fontName, size: adaptDecimal(16))!
        
        /// 用于大部分正文内容文字 【15】
        static let mainContent = UIFont(name: fontName, size: adaptDecimal(15))!
        
        /// 用于交易、体现记录中文字【14】
        static let transaction = UIFont(name: fontName, size: adaptDecimal(14))!
        
        /// 用于协调等辅助性文字 【12】
        static let light = UIFont(name: fontName, size: adaptDecimal(12))!
        
        /// 用于tabbar 【10】
        static let tabBar = UIFont(name: fontName, size: adaptDecimal(10))!
    }
}
