//
//  HXBSignInController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/19.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

/// 登录
class HXBSignInController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "登录"
        viewModel = HXBSignUpViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var viewModel: HXBSignUpViewModel!
    
    fileprivate let phoneView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_phone"), placeholder: "手机号")
    fileprivate let pwdView = HXBInputFieldView.eyeFieldView(leftImage: UIImage("input_password"), placeholder: "密码")
    
    fileprivate var captcha: String?
}

// MARK: - UI
extension HXBSignInController {
    fileprivate func setUI() {
        hideNavigationBar = false
        navBgImage = UIImage.zz_image(withColor: UIColor.clear)
        
        showBack = true
        
        let waveView = HXBNavWaveView()
        view.addSubview(waveView)
        
        phoneView.inputLengthLimit = hxb.size.phoneLength
        phoneView.keyboardType = .numberPad
        phoneView.fieldEventSignal.observeValues { [weak self] text in
            if text.count == hxb.size.phoneLength {
                self?.viewModel.checkExistMobile(text)
            }
        }
        
        phoneView.text = HXBKeychain[hxb.keychain.key.phone]
        view.addSubview(phoneView)
        view.addSubview(pwdView)
        
        let signInBtn = UIButton(title: "同意用户协议并登录", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(signIn))
        signInBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        signInBtn.layer.masksToBounds = true
        view.addSubview(signInBtn)
        
        let tipView = UIView()
        view.addSubview(tipView)
        
        let tipLabel = UILabel(text: "还没有账户？", font: hxb.font.firstClass, textColor: hxb.color.light)
        let signUpBtn = UIButton(title: "立即注册", font: hxb.font.firstClass, titleColor: hxb.color.mostImport, target: self, action: #selector(toSignUp))
        tipView.addSubview(tipLabel)
        tipView.addSubview(signUpBtn)
        
        let bottomView = UIView()
        view.addSubview(bottomView)
        
        let protocolBtn = UIButton(title: "用户协议", font: hxb.font.light, titleColor: hxb.color.light, target: self, action: #selector(toUserProtocol))
        let forgetPwdBtn = UIButton(title: "忘记密码", font: hxb.font.light, titleColor: hxb.color.light, target: self, action: #selector(toForgetPwd))
        let sepLine = UIView.sepLine()
        
        bottomView.addSubview(protocolBtn)
        bottomView.addSubview(forgetPwdBtn)
        bottomView.addSubview(sepLine)
        
        phoneView.snp.makeConstraints { (maker) in
            maker.top.equalTo(waveView.snp.bottom).offset(40)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(hxb.size.fieldCommonHeight)
        }
        
        pwdView.snp.makeConstraints { (maker) in
            maker.left.right.height.equalTo(phoneView)
            maker.top.equalTo(phoneView.snp.bottom)
        }
        
        signInBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(pwdView.snp.bottom).offset(50)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
        
        tipView.snp.makeConstraints { (maker) in
            maker.top.equalTo(signInBtn.snp.bottom).offset(30)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(24)
        }
        
        tipLabel.snp.makeConstraints { (maker) in
            maker.top.left.bottom.equalToSuperview()
            maker.right.equalTo(signUpBtn.snp.left)
        }
        
        signUpBtn.snp.makeConstraints { (maker) in
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
extension HXBSignInController {
    override func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func signIn() {
        guard let phone = phoneView.text else {
            HXBHUD.show(toast: "请输入准确的手机号", in: view)
            return
        }
        
        guard let pwd = pwdView.text else {
            HXBHUD.show(toast: "请输入密码", in: view)
            return
        }
        guard pwd.count >= 8 && pwd.count <= 20 else {
            HXBHUD.show(toast: "请输入8-20位数字与字母的组合", in: view)
            return
        }
        
        viewModel.signin(mobile: phone, password: pwd, captcha: captcha).startWithValues { (isSuccess, needCaptcha) in
            if isSuccess {
                self.dismiss(animated: true, completion: nil)
            } else if needCaptcha {
                self.captcha = nil
                HXBCaptchaValidateView.show(fromView: self.view) { captcha in
                    self.captcha = captcha
                    self.signIn()
                }
            }
        }
    }
    
    @objc fileprivate func toSignUp() {
        HXBStartSignUpController().pushFrom(controller: self, animated: true)
    }
    
    @objc fileprivate func toUserProtocol() {
        HXBWebController(urlString: hxb.api.sign_up_agreement).pushFrom(controller: self, animated: true)
    }
    
    @objc fileprivate func toForgetPwd() {
        
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

