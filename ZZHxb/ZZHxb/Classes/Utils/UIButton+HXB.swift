//
//  UIButton+HXB.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/20.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String? = nil,
                     font: UIFont,
                     titleColor: UIColor = UIColor.darkText,
                     imageName: String? = nil,
                     hilightedImageName: String? = nil,
                     selectedImageName: String? = nil,
                     backgroundImageName: String? = nil,
                     hilightedBackgroundImageName: String? = nil,
                     selectedBackgroundImageName: String? = nil,
                     backgroundColor: UIColor? = nil,
                     target: Any? = nil,
                     action: Selector? = nil) {
        
        self.init(title: title,
                  fontSize: 16,
                  titleColor: titleColor,
                  imageName: imageName,
                  hilightedImageName: hilightedImageName,
                  selectedImageName: selectedImageName,
                  backgroundImageName: backgroundImageName,
                  hilightedBackgroundImageName: hilightedBackgroundImageName,
                  selectedBackgroundImageName: selectedBackgroundImageName,
                  backgroundColor: backgroundColor,
                  target: target,
                  action: action)
        
        titleLabel?.font = font
        
        sizeToFit()
    }
}
