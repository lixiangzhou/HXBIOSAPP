//
//  HXBMobileUnbindingController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/29.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift

class HXBMobileUnbindingController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "解绑原手机号"
        setUI()
        setBindings()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate let viewModel = HXBMobileUnbindingViewModel()
    
    fileprivate var getCodeBtn: UIButton!
    fileprivate var codeView: HXBInputFieldView!
    fileprivate var nextBtn: UIButton!
    fileprivate let phoneLabel = ActiveLabel(text: "如有问题，请联系红小宝客服：\(hxb.string.servicePhone)", font: hxb.font.light, textColor: hxb.color.important, numOfLines: 0)
}

// MARK: - UI
extension HXBMobileUnbindingController {
    fileprivate func setUI() {
        let tipLabel = UILabel(text: "", font: hxb.font.mainContent, textColor: hxb.color.important)
        tipLabel.attributedText = viewModel.tipAttributeString
        view.addSubview(tipLabel)
        
        getCodeBtn = UIButton(title: "获取验证码", font: hxb.font.light, titleColor: hxb.color.mostImport, target: viewModel, action: #selector(HXBMobileUnbindingViewModel.getCode))
        getCodeBtn.frame = CGRect(x: 0, y: 0, width: 85, height: 30)
        getCodeBtn.layer.masksToBounds = true
        getCodeBtn.layer.borderColor = hxb.color.mostImport.cgColor
        getCodeBtn.layer.borderWidth = hxb.size.sepLineWidth
        getCodeBtn.layer.cornerRadius = hxb.size.normalButtonCornerRadius
        
        codeView = HXBInputFieldView.rightClickViewFieldView(leftImage: UIImage("input_security_code"), placeholder: "短信验证码", clickView: getCodeBtn, bottomLineColor: hxb.color.mostImport)
        codeView.inputLengthLimit = 6
        codeView.keyboardType = .numberPad
        view.addSubview(codeView)
        
        nextBtn = UIButton(title: "下一步", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.sepLine, target: self, action: #selector(nextClick))
        nextBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        nextBtn.layer.masksToBounds = true
        nextBtn.isUserInteractionEnabled = false
        view.addSubview(nextBtn)
        
        let customType = ActiveType.custom(pattern: "\(hxb.string.servicePhone)")
        phoneLabel.enabledTypes.append(customType)
        
        phoneLabel.customize { label in
            label.lineSpacing = 4
            label.customColor[customType] = hxb.color.linkActivity
            label.handleCustomTap(for: customType) { string in
                HXBAlertController.phoneCall(phone: string, title: "红小宝客服电话", message: string, left: "取消", right: "拨打", isAsyncMain: true)
            }
        }
        
        view.addSubview(phoneLabel)
        
        tipLabel.snp.makeConstraints { maker in
            maker.top.equalTo(30)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
        }
        
        codeView.snp.makeConstraints { maker in
            maker.top.equalTo(tipLabel.snp.bottom).offset(hxb.size.view2View)
            maker.left.right.equalTo(tipLabel)
            maker.height.equalTo(hxb.size.inputHeight)
        }
        
        nextBtn.snp.makeConstraints { maker in
            maker.top.equalTo(codeView.snp.bottom).offset(50)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
        
        phoneLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(-30)
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
        
        codeView.inputFieldSignal.map { $0.count >= 4}.skipRepeats().observeValues { enabled in
            self.nextBtn.isUserInteractionEnabled = enabled
            self.nextBtn.backgroundColor = enabled ? hxb.color.mostImport : hxb.color.sepLine
        }
    }
}

// MARK: - Action
extension HXBMobileUnbindingController {
    
    @objc fileprivate func nextClick() {
        if checkInput(inputView: codeView, toastEmpty: "短信验证码不能为空", toastCount: "请输入6位短信验证码", limitCount: 6, toastView: view) == false {
            return
        }
        let code = codeView.text!.replacingOccurrences(of: " ", with: "")
        viewModel.checkIdentifySms(code: code) { isSuccess in
            if isSuccess {
                HXBMobileBindingController().pushFrom(controller: self, animated: true)
            }
        }
    }
}

// MARK: - Helper
extension HXBMobileUnbindingController {
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        phoneLabel.snp.updateConstraints { maker in
            maker.bottom.equalTo(-view.safeAreaInsets.bottom - 30)
        }
    }
}
