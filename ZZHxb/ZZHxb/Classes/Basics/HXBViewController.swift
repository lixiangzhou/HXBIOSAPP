//
//  HXBViewController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(hideNavigationBar, animated: animated)
    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
//
//    deinit {
//        
//    }

    // MARK: - Public Property
    
    let baseViewModel = HXBViewModel()
    
    /// 单独的隐藏导航栏
    var hideNavigationBar = false
    
    // MARK: - Private Property
    
}

// MARK: - Observers
extension HXBViewController {
    fileprivate func addObservers() {
        
    }
}

// MARK: - UI
extension HXBViewController {
    fileprivate func setUI() {
        let navBackImage = UIImage.zz_gradientImage(fromColor: hxb.color.importantFill(hex: "fe654d"),
                                                    toColor: hxb.color.importantFill(hex: "ff3d4f"),
                                                    size: CGSize(width: UIScreen.zz_width, height: hxb.size.navigationHeight))
        navigationController?.navigationBar.setBackgroundImage(navBackImage, for: UIBarMetrics.default)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: hxb.font.navTitle,
                                                                   NSAttributedStringKey.foregroundColor: hxb.color.white]
    }
}

// MARK: - Action
extension HXBViewController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBViewController {
    
}

// MARK: - Other
extension HXBViewController {
    
}

// MARK: - Public
extension HXBViewController {
    
}

