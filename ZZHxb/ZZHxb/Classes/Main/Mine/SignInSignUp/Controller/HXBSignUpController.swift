//
//  HXBSignUpController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/20.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBSignUpController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
}

// MARK: - UI
extension HXBSignUpController {
    fileprivate func setUI() {
        title = "登录"
        
        hideNavigationBar = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        showBack = true
        
        let waveView = HXBNavWaveView()
        view.addSubview(waveView)
    }
}

// MARK: - Action
extension HXBSignUpController {
    override func back() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Network
extension HXBSignUpController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBSignUpController {
    
}

// MARK: - Other
extension HXBSignUpController {
    
}

// MARK: - Public
extension HXBSignUpController {
    
}

