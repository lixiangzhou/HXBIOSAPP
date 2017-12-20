//
//  UIViewController+HXB.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/19.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// 导航栏控制器返回
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    /// 导航栏控制器 push
    func pushFrom(controller: UIViewController, animated: Bool) {
        controller.navigationController?.pushViewController(self, animated: animated)
    }
    
    
    /// Present
    func presentFrom(controller: UIViewController, animated: Bool, completion: (() -> ())? = nil) {
        controller.present(self, animated: animated, completion: completion)
    }
}
