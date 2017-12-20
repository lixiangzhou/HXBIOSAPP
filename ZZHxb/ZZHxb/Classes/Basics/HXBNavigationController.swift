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

// MARK: - Network
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
        if childViewControllers.count == 0 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage("navigation_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popViewController(animated:)))
        }
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - Public
extension HXBNavigationController {
    
}

