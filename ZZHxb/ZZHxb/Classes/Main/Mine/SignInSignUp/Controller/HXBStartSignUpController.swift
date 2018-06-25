//
//  HXBStartSignUpController.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/3.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

/// 准备注册
class HXBStartSignUpController: HXBViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "注册"
        viewModel = HXBSignUpViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
    }
    
    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var phoneField = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_phone"), text: nil, placeholder: "请输入常用的手机号")
    fileprivate var viewModel: HXBSignUpViewModel!
}

// MARK: - UI
extension HXBStartSignUpController {
    fileprivate func setUI() {
        hideNavigationBar = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let waveView = HXBNavWaveView()
        view.addSubview(waveView)
        
        phoneField.keyboardType = .numberPad
        phoneField.inputLengthLimit = hxb.size.phoneLength
        phoneField.inputViewChangeClosure = { field in
            let text = field.text ?? ""
            if text.count == hxb.size.phoneLength {
                self.viewModel.checkMobile(text)
            }
        }
        view.addSubview(phoneField)
        
        let toSignUpBtn = UIButton(title: "下一步", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(toSignUp))
        toSignUpBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        toSignUpBtn.layer.masksToBounds = true
        view.addSubview(toSignUpBtn)
        
        let toSignInBtn = UIButton(title: "我有账户，去登录", font: hxb.font.light, titleColor: hxb.color.light, target: self, action: #selector(toSignIn))
        view.addSubview(toSignInBtn)
        
        phoneField.snp.makeConstraints { (maker) in
            maker.top.equalTo(waveView.snp.bottom).offset(30)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(hxb.size.fieldCommonHeight)
        }
        
        toSignUpBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(phoneField.snp.bottom).offset(50)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
        
        toSignInBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(toSignUpBtn.snp.bottom).offset(30)
            maker.centerX.equalToSuperview()
        }
    }
}

// MARK: - Action
extension HXBStartSignUpController {
    @objc fileprivate func toSignUp() {
        HXBCaptchaValidateView.show(fromView: view) { captcha in
            let phone = self.phoneField.text ?? ""
            self.viewModel.getSmsCode(phone: phone, captcha: captcha ?? "").startWithValues { isSuccess in
                if isSuccess {
                    let signUpVC = HXBSignUpController()
                    signUpVC.phoneNo = phone
                    signUpVC.pushFrom(controller: self, animated: true)
                }
            }
        }
    }
    
    @objc fileprivate func toSignIn() {
        pop(animated: true)
    }
}
