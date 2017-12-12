//
//  HXBTabBarController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBTabBarController: UITabBarController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildControllers()
        setUI()
        addObservers()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
//    
//    deinit {
//        
//    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    
}

// MARK: - Observers
extension HXBTabBarController {
    fileprivate func addObservers() {
        
    }
}

// MARK: - UI
extension HXBTabBarController {
    fileprivate func addChildControllers() {
        
    }
    
    fileprivate func setUI() {
        
    }
    
    private func add(childController: HXBViewController, title: String, imageName: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        
        let navVC = HXBNavigationController(rootViewController: childController)
        addChildViewController(navVC)
    }
}

// MARK: - Action
extension HXBTabBarController {
    
}

// MARK: - Network
extension HXBTabBarController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBTabBarController {
    
}

// MARK: - Other
extension HXBTabBarController {
    
}

// MARK: - Public
extension HXBTabBarController {
    
}

