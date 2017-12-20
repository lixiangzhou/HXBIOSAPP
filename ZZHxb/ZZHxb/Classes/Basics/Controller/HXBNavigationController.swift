//
//  HXBNavigationController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBNavigationController: UINavigationController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setFullScreenBackGesture()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension HXBNavigationController {
    fileprivate func setUI() {
        navigationBar.shadowImage = UIImage()
    }
}

// MARK: - Action
extension HXBNavigationController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBNavigationController {
}

// MARK: - Other
extension HXBNavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if childViewControllers.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage("navigation_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popViewController(animated:)))
        }
    }
    
    fileprivate func setFullScreenBackGesture() {
        let target = interactivePopGestureRecognizer?.delegate
        let sel = Selector(("handleNavigationTransition:"))
        let gesture = UIPanGestureRecognizer(target: target, action: sel)
        view.addGestureRecognizer(gesture)
        interactivePopGestureRecognizer?.isEnabled = false
    }
}

// MARK: - Public
extension HXBNavigationController {
    
}

