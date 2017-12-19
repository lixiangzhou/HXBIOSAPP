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
        NotificationCenter.default.reactive.notifications(forName: hxb.notification.name.notLogin).observeValues { notification in
            HXBNavigationController(rootViewController: HXBSignInController()).presentFrom(controller: self, animated: true)
        }
    }
}

// MARK: - UI
extension HXBTabBarController {
    fileprivate func addChildControllers() {
        add(childController: HXBHomeController(), title: "首页", imageName: "tabbar_home")
        add(childController: HXBInvestController(), title: "投资", imageName: "tabbar_investment")
        add(childController: HXBMineController(), title: "我的", imageName: "tabbar_mine")
    }
    
    fileprivate func setUI() {
        view.backgroundColor = hxb.color.white
    }
    
    private func add(childController: HXBViewController, title: String, imageName: String) {
        childController.title = title
        
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: hxb.color.mostImport], for: .selected)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: hxb.color.light], for: .normal)
        
        childController.tabBarItem.image = UIImage(imageName)
        childController.tabBarItem.selectedImage = UIImage(imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
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

