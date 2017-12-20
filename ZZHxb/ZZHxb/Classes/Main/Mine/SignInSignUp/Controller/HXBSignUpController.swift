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
        
        let phoneField = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_phone"), text: nil, placeholder: "手机号")
        let pwdField = HXBInputFieldView.eyeFieldView(leftImage: UIImage("input_password"), placeholder: "密码")
        
        view.addSubview(phoneField)
        view.addSubview(pwdField)
        
        let signUpBtn = UIButton(title: "同意用户协议并登录", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(signUp))
        signUpBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        signUpBtn.layer.masksToBounds = true
        view.addSubview(signUpBtn)
        
        let tipView = UIView()
        view.addSubview(tipView)
        
        let tipLabel = UILabel(text: "还没有账户？", font: hxb.font.firstClass, textColor: hxb.color.light)
        let signInBtn = UIButton(title: "立即注册", font: hxb.font.firstClass, titleColor: hxb.color.mostImport, target: self, action: #selector(toSignIn))
        tipView.addSubview(tipLabel)
        tipView.addSubview(signInBtn)
        
        let bottomView = UIView()
        view.addSubview(bottomView)
        
        let protocolBtn = UIButton(title: "用户协议", font: hxb.font.light, titleColor: hxb.color.light, target: self, action: #selector(toUserProtocol))
        let forgetPwdBtn = UIButton(title: "忘记密码", font: hxb.font.light, titleColor: hxb.color.light, target: self, action: #selector(toForgetPwd))
        let sepLine = UIView.sepLine()
        
        bottomView.addSubview(protocolBtn)
        bottomView.addSubview(forgetPwdBtn)
        bottomView.addSubview(sepLine)
        
        phoneField.snp.makeConstraints { (maker) in
            maker.top.equalTo(waveView.snp.bottom).offset(adaptDecimal(40))
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(60)
        }
        
        pwdField.snp.makeConstraints { (maker) in
            maker.left.right.height.equalTo(phoneField)
            maker.top.equalTo(phoneField.snp.bottom)
        }
        
        signUpBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(pwdField.snp.bottom).offset(adaptDecimal(50))
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
        
        tipView.snp.makeConstraints { (maker) in
            maker.top.equalTo(signUpBtn.snp.bottom).offset(30)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(24)
        }
        
        tipLabel.snp.makeConstraints { (maker) in
            maker.top.left.bottom.equalToSuperview()
            maker.right.equalTo(signInBtn.snp.left)
        }
        
        signInBtn.snp.makeConstraints { (maker) in
            maker.top.right.bottom.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(-30)
            maker.height.equalTo(15)
        }
        
        protocolBtn.snp.makeConstraints { (maker) in
            maker.top.left.bottom.equalToSuperview()
            maker.right.equalTo(forgetPwdBtn.snp.left).offset(-28)
        }
        
        forgetPwdBtn.snp.makeConstraints { (maker) in
            maker.top.right.bottom.equalToSuperview()
        }
        
        sepLine.snp.makeConstraints { (maker) in
            maker.top.centerX.bottom.equalToSuperview()
            maker.width.equalTo(0.5)
        }
    }
}

// MARK: - Action
extension HXBSignUpController {
    override func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func signUp() {
        
    }
    
    @objc fileprivate func toSignIn() {
        HXBSignInController().pushFrom(controller: self, animated: true)
    }
    
    @objc fileprivate func toUserProtocol() {
        
    }
    
    @objc fileprivate func toForgetPwd() {
        
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

