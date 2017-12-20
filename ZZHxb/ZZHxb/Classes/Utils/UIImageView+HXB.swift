//
//  UIImageView+HXB.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/20.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(named: String) {
        self.init(image: UIImage(named))
    }
}
