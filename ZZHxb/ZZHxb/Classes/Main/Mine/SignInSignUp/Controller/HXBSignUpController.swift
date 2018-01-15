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
    // MARK: - Public Property
    var phoneNo = ""
    var smsCodeView: HXBInputFieldView!
    var pwdView: HXBInputFieldView!
    var inviteCodeView: HXBInputFieldView!
    
    fileprivate var viewModel = HXBSignUpViewModel()
}

// MARK: - UI
extension HXBSignUpController {
    fileprivate func setUI() {
        title = "注册"
        
        hideNavigationBar = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let waveView = HXBNavWaveView()
        view.addSubview(waveView)
        
        let tipLabel = UILabel()
        tipLabel.attributedText = getTipString(phone: self.phoneNo)
        
        
        let (smsOrVoiceValidView, voiceBtn) = HXBInputFieldView.smsOrVoiceValidFieldView(leftImage: UIImage("input_security_code"), placeholder: "请输入验证码")
        pwdView = HXBInputFieldView.eyeFieldView(leftImage: UIImage("input_password"), placeholder: "密码为8-20位数字与字母的组合")
        inviteCodeView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_invite_code"), placeholder: "请输入邀请码")
        
        smsCodeView = smsOrVoiceValidView
        smsOrVoiceValidView.inputLengthLimit = 6
        pwdView.inputLengthLimit = 20
        inviteCodeView.inputLengthLimit = 6
        
        voiceBtn.addTarget(self, action: #selector(getVoiceCode), for: .touchUpInside)
        
        view.addSubview(tipLabel)
        view.addSubview(smsOrVoiceValidView)
        view.addSubview(pwdView)
        view.addSubview(inviteCodeView)
        
        let signUpBtn = UIButton(title: "注册", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(signUp))
        
        signUpBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        signUpBtn.layer.masksToBounds = true
        view.addSubview(signUpBtn)
        
        tipLabel.snp.makeConstraints { maker in
            maker.top.equalTo(waveView.snp.bottom).offset(10)
            maker.centerX.equalTo(view)
        }
        
        smsOrVoiceValidView.snp.makeConstraints { maker in
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.top.equalTo(tipLabel.snp.bottom).offset(hxb.size.view2View)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(hxb.size.fieldCommonHeight)
        }
        
        pwdView.snp.makeConstraints { maker in
            maker.left.right.height.equalTo(smsOrVoiceValidView)
            maker.top.equalTo(smsOrVoiceValidView.snp.bottom)
        }
        
        inviteCodeView.snp.makeConstraints { maker in
            maker.left.right.height.equalTo(smsOrVoiceValidView)
            maker.top.equalTo(pwdView.snp.bottom)
        }
        
        signUpBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(inviteCodeView.snp.bottom).offset(50)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
    }
}

// MARK: - Action
extension HXBSignUpController {
    @objc fileprivate func getVoiceCode() {
        
    }
    
    @objc fileprivate func signUp() {
        guard let smsCode = smsCodeView.text else {
            HXBHUD.show(toast: "请输入验证码", in: view)
            return
        }
        guard smsCode.count == 6 else {
            HXBHUD.show(toast: "请输入6位验证码", in: view)
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
        
        viewModel.signup(mobile: phoneNo, smsCode: smsCode, password: pwd, inviteCode: inviteCodeView.text) { (isSuccess, toast) in
            if isSuccess {
                HXBKeychain[hxb.keychain.key.phone] = self.phoneNo
                self.dismiss(animated: true, completion: nil)
            } else if let toast = toast {
                HXBHUD.show(toast: toast, in: self.view)
            }
        }
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
    fileprivate func getShowPhone(phone: String) -> String {
        if phone.count == 11 {
            let startIdx = phone.startIndex
            let endIdx = phone.endIndex;
            return "\(phone[startIdx...phone.index(startIdx, offsetBy: 2)])****\(phone[phone.index(endIdx, offsetBy: -4)...phone.index(endIdx, offsetBy: -1)])"
        }
        return phone
    }
    
    fileprivate func getTipString(phone: String) -> NSAttributedString {
        let showPhone = getShowPhone(phone: self.phoneNo)
        let attributeString = NSMutableAttributedString(attributedString: NSAttributedString(string: "已向手机\(showPhone)发送短信",
            attributes: [NSAttributedStringKey.font: hxb.font.mainContent,
                         NSAttributedStringKey.foregroundColor: hxb.color.important]))
        
        attributeString.setAttributes([NSAttributedStringKey.foregroundColor: hxb.color.mostImport], range: NSMakeRange(4, showPhone.count))
        return attributeString
    }
}

// MARK: - Other
extension HXBSignUpController {
    
}

// MARK: - Public
extension HXBSignUpController {
    
}

