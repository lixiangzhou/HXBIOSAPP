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
    @discardableResult
    func pushFrom(controller: UIViewController, animated: Bool) -> Self {
        controller.navigationController?.pushViewController(self, animated: animated)
        return self
    }
    
    
    /// Present
    @discardableResult
    func presentFrom(controller: UIViewController, animated: Bool, completion: (() -> ())? = nil, isAsyncMain: Bool = false) -> Self {
        if isAsyncMain {
            DispatchQueue.main.async {
                controller.present(self, animated: animated, completion: completion)
            }
        } else {
            controller.present(self, animated: animated, completion: completion)
        }
        return self
    }
}
