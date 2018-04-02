//
//  HXBMobileBindingController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/30.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBMobileBindingController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "绑定新手机号"
        viewModel = HXBMobileBindingViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
        setBindings()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var viewModel: HXBMobileBindingViewModel!
    
    fileprivate let phoneView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_phone"), placeholder: "新手机号", bottomLineColor: hxb.color.sepLine)
    fileprivate var getCodeBtn: UIButton!
    fileprivate var codeView: HXBInputFieldView!
    fileprivate var nextBtn: UIButton!
}

// MARK: - UI
extension HXBMobileBindingController {
    fileprivate func setUI() {
        phoneView.keyboardType = .numberPad
        phoneView.inputLengthLimit = hxb.size.phoneLength
        view.addSubview(phoneView)
        
        getCodeBtn = UIButton(title: "获取验证码", font: hxb.font.light, titleColor: hxb.color.mostImport, target: self, action: #selector(getCode))
        getCodeBtn.frame = CGRect(x: 0, y: 0, width: 85, height: 30)
        getCodeBtn.layer.masksToBounds = true
        getCodeBtn.layer.borderColor = hxb.color.mostImport.cgColor
        getCodeBtn.layer.borderWidth = hxb.size.sepLineWidth
        getCodeBtn.layer.cornerRadius = hxb.size.normalButtonCornerRadius
        
        codeView = HXBInputFieldView.rightClickViewFieldView(leftImage: UIImage("input_security_code"), placeholder: "短信验证码", clickView: getCodeBtn, bottomLineColor: hxb.color.sepLine)
        codeView.inputLengthLimit = hxb.size.msgCodeLength
        codeView.keyboardType = .numberPad
        view.addSubview(codeView)
        
        nextBtn = UIButton(title: "下一步", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.sepLine, target: self, action: #selector(nextClick))
        nextBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        nextBtn.layer.masksToBounds = true
        nextBtn.isUserInteractionEnabled = false
        view.addSubview(nextBtn)
        
        phoneView.snp.makeConstraints { maker in
            maker.top.equalTo(hxb.size.view2View)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(hxb.size.inputHeight)
        }
        
        codeView.snp.makeConstraints { maker in
            maker.top.equalTo(phoneView.snp.bottom).offset(hxb.size.view2View)
            maker.left.right.equalTo(phoneView)
            maker.height.equalTo(hxb.size.inputHeight)
        }
        
        nextBtn.snp.makeConstraints { maker in
            maker.top.equalTo(codeView.snp.bottom).offset(50)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
    }
    
    fileprivate func setBindings() {
        viewModel.timerSignal.observeValues { time in
            let end = time == 0
            self.getCodeBtn.isUserInteractionEnabled = end
            self.getCodeBtn.setTitle(end ? "获取验证码" : "\(time)s", for: .normal)
            self.getCodeBtn.setTitleColor(end ? hxb.color.mostImport : hxb.color.white, for: .normal)
            self.getCodeBtn.backgroundColor = end ? hxb.color.white : hxb.color.sepLine
            self.getCodeBtn.layer.borderColor = end ? hxb.color.mostImport.cgColor : UIColor.clear.cgColor
        }
        
        codeView.inputFieldSignal.map { $0.count >= 6}.skipRepeats().observeValues { enabled in
            self.nextBtn.isUserInteractionEnabled = enabled
            self.nextBtn.backgroundColor = enabled ? hxb.color.mostImport : hxb.color.sepLine
        }
    }
}

// MARK: - Action
extension HXBMobileBindingController {
    @objc fileprivate func nextClick() {
        if checkInput(inputView: phoneView, toastEmpty: "请输入新手机号", toastCount: "请输入11位新手机号", limitCount: hxb.size.phoneLength, toastView: view) == false ||
            checkInput(inputView: codeView, toastEmpty: "请输入验证码", toastCount: "请输入6位验证码", limitCount: hxb.size.msgCodeLength, toastView: view) == false {
            return
        }
        let mobile = phoneView.text!.replacingOccurrences(of: " ", with: "")
        let code = codeView.text!.replacingOccurrences(of: " ", with: "")
        viewModel.modifyMobile(mobile, code: code) { isSuccess in
            if isSuccess {
                HXBHUD.show(toast: "修改成功，请用新手机号登录")
                HXBKeychain[hxb.keychain.key.phone] = mobile
                self.tabBarController?.selectedIndex = 0
                self.navigationController?.popToRootViewController(animated: false)
                hxb.notification.notLogin.post()
            }
        }
        
    }
    
    @objc fileprivate func getCode() {
        if checkInput(inputView: phoneView, toastEmpty: "请输入新手机号", toastCount: "请输入11位新手机号", limitCount: hxb.size.phoneLength, toastView: view) == false {
            return
        }
        let mobile = phoneView.text!.replacingOccurrences(of: " ", with: "")
        viewModel.getCode(mobile: mobile)
    }
}

// MARK: - Network
extension HXBMobileBindingController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBMobileBindingController {
    
}

// MARK: - Other
extension HXBMobileBindingController {
    
}

// MARK: - Public
extension HXBMobileBindingController {
    
}

