//
//  HXBSignInController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/19.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBSignInController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension HXBSignInController {
    fileprivate func setUI() {
        title = "注册"
        
        hideNavigationBar = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let waveView = HXBNavWaveView()
        view.addSubview(waveView)
        
        let phoneField = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_phone"), text: nil, placeholder: "请输入常用的手机号")
        view.addSubview(phoneField)
        
        let signInBtn = UIButton(title: "下一步", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(signIn))
        signInBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        signInBtn.layer.masksToBounds = true
        view.addSubview(signInBtn)
        
        let toSignUpBtn = UIButton(title: "我有账户，去登录", font: hxb.font.light, titleColor: hxb.color.light, target: self, action: #selector(toSignUp))
        view.addSubview(toSignUpBtn)
        
        phoneField.snp.makeConstraints { (maker) in
            maker.top.equalTo(waveView.snp.bottom).offset(30)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(hxb.size.fieldCommonHeight)
        }
        
        signInBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(phoneField.snp.bottom).offset(adaptDecimal(50))
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
        
        toSignUpBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(signInBtn.snp.bottom).offset(30)
            maker.centerX.equalToSuperview()
        }
    }
}

// MARK: - Action
extension HXBSignInController {
    @objc fileprivate func signIn() {
        
    }
    
    @objc fileprivate func toSignUp() {
        pop(animated: true)
    }
    
}

// MARK: - Network
extension HXBSignInController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBSignInController {
    
}

// MARK: - Other
extension HXBSignInController {
    
}

// MARK: - Public
extension HXBSignInController {
    
}

