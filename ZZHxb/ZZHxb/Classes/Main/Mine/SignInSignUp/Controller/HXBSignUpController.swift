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
        addObservers()
    }
}

// MARK: - Observers
extension HXBSignUpController {
    fileprivate func addObservers() {
        
    }
}

// MARK: - UI
extension HXBSignUpController {
    fileprivate func setUI() {
        title = "登录"
        
        hideNavigationBar = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        showBack = true
        
        let waveView = HXBTopWaveView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 111))
        view.addSubview(waveView)
    }
}

// MARK: - Action
extension HXBSignUpController {
    
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

