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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(hideNavigationBar, animated: animated)
    }
  
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Public Property
    
    let baseViewModel = HXBViewModel()
    
    /// 单独的隐藏导航栏
    var hideNavigationBar = false
    
    /// 显示左边的返回按钮
    var showBack: Bool {
        set {
            let backItem = UIBarButtonItem(image: UIImage("navigation_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
            navigationItem.leftBarButtonItem = newValue ? backItem : nil
        }
        get {
            return navigationItem.leftBarButtonItem == nil
        }
    }
    
    // MARK: - Private Property
    
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
        
        view.backgroundColor = hxb.color.white
    }
}

// MARK: - Action
extension HXBViewController {
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Public
extension HXBViewController {
    
}

