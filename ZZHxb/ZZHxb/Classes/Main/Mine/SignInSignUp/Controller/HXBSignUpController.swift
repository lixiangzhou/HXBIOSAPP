//
//  HXBSignUpController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/20.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift

/// 注册
class HXBSignUpController: HXBViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "注册"
        viewModel = HXBSignUpViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
        startTimer()
    }
    
    // MARK: - Public Property
    var phoneNo = ""
    var captcha = ""
    var smsCodeView: HXBInputFieldView!
    var smsBtn: UIButton!
    var pwdView: HXBInputFieldView!
    var inviteCodeView: HXBInputFieldView!
    var signUpBtn: UIButton!
    weak var timer: Timer?
    var second: Int = 60
    
    fileprivate var viewModel: HXBSignUpViewModel!
}

// MARK: - UI
extension HXBSignUpController {
    fileprivate func setUI() {
        hideNavigationBar = false
        navBgImage = UIImage.zz_image(withColor: UIColor.clear)
        
        let waveView = HXBNavWaveView()
        view.addSubview(waveView)
        
        let tipLabel = UILabel()
        tipLabel.attributedText = getTipString(phone: self.phoneNo)
        
        let (_smsCodeView, _smsBtn) = HXBInputFieldView.smsValidFieldView(leftImage: UIImage("input_security_code"), placeholder: "请输入短信验证码")
        self.smsBtn = _smsBtn
        self.smsCodeView = _smsCodeView
        
        pwdView = HXBInputFieldView.eyeFieldView(leftImage: UIImage("input_password"), placeholder: "密码为8-20位数字与字母的组合")
        inviteCodeView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_invite_code"), placeholder: "请输入邀请码（选填）")
        
        smsCodeView.inputLengthLimit = hxb.size.msgCodeLength
        pwdView.inputLengthLimit = 20
        inviteCodeView.inputLengthLimit = hxb.size.msgCodeLength
        
        smsBtn.addTarget(self, action: #selector(getSmsCode), for: .touchUpInside)
        
        view.addSubview(tipLabel)
        view.addSubview(smsCodeView)
        view.addSubview(pwdView)
        view.addSubview(inviteCodeView)
        
        signUpBtn = UIButton(title: "注册", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(signUp))
        
        signUpBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        signUpBtn.layer.masksToBounds = true
        signUpBtn.isEnabled = false
        signUpBtn.backgroundColor = hxb.color.alertCancelBtn
        view.addSubview(signUpBtn)
        
        tipLabel.snp.makeConstraints { maker in
            maker.top.equalTo(waveView.snp.bottom).offset(40)
            maker.centerX.equalTo(view)
        }
        
        smsCodeView.snp.makeConstraints { maker in
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.top.equalTo(tipLabel.snp.bottom).offset(hxb.size.view2View)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(hxb.size.fieldCommonHeight)
        }
        
        pwdView.snp.makeConstraints { maker in
            maker.left.right.height.equalTo(smsCodeView)
            maker.top.equalTo(smsCodeView.snp.bottom)
        }
        
        inviteCodeView.snp.makeConstraints { maker in
            maker.left.right.height.equalTo(smsCodeView)
            maker.top.equalTo(pwdView.snp.bottom)
        }
        
        signUpBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(inviteCodeView.snp.bottom).offset(50)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
        
        reactive_bind(viewModel)
    }
    
    private func reactive_bind(_ vm: HXBSignUpViewModel) {
        let btnEnabledSignal = smsCodeView.fieldTextSignal.producer.combineLatest(with: pwdView.fieldTextSignal.producer).map{ smsText, pwdText -> Bool in
            return (smsText ?? "").count == 6 && ((pwdText ?? "").count >= 8 && (pwdText ?? "").count <= 20)
        }
        
        signUpBtn.reactive.isEnabled <~ btnEnabledSignal
        signUpBtn.reactive.backgroundColor <~ btnEnabledSignal.map { enabled -> UIColor in
            return enabled ? hxb.color.mostImport : hxb.color.alertCancelBtn
        }
    }
}

// MARK: - Action
extension HXBSignUpController {
    @objc fileprivate func getSmsCode() {
        startTimer()
        viewModel.getSmsCode(phone: phoneNo, captcha: captcha).start()
    }
    
    fileprivate func startTimer() {
        stopTimer()
        
        smsBtn.isEnabled = false
        smsBtn.layer.borderColor = hxb.color.alertCancelBtn.cgColor
        smsBtn.setTitleColor(hxb.color.white, for: .normal)
        smsBtn.setTitle("\(second)", for: .normal)
        smsBtn.backgroundColor = hxb.color.alertCancelBtn
        timer = Timer.zz_scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopTimer() {
        smsBtn.isEnabled = true
        smsBtn.layer.borderColor = hxb.color.mostImport.cgColor
        smsBtn.setTitleColor(hxb.color.mostImport, for: .normal)
        smsBtn.setTitle("短信验证码", for: .normal)
        smsBtn.backgroundColor = hxb.color.white
        timer?.invalidate()
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
        
        viewModel.signup(mobile: phoneNo, smsCode: smsCode, password: pwd, inviteCode: inviteCodeView.text).startWithValues { isSuccess in
            if isSuccess {
                HXBKeychain[hxb.keychain.key.phone] = self.phoneNo
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

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
    @objc fileprivate func tick() {
        second -= 1
        smsBtn.setTitle(String(format: "%02d", second), for: .normal)
        if second <= 0 {
            stopTimer()
        }
    }
}
