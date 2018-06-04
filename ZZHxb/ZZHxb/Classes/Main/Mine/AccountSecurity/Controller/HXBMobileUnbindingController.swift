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
        viewModel = HXBMobileUnbindingViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
        setBindings()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var viewModel: HXBMobileUnbindingViewModel!
    
    fileprivate let idcardView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_idcard_red"), placeholder: "请输入身份证号码", bottomLineColor: hxb.color.sepLine)
    fileprivate var getCodeBtn: UIButton!
    fileprivate var codeView: HXBInputFieldView!
    fileprivate var nextBtn: UIButton!
    fileprivate let phoneLabel = ActiveLabel(text: "如有问题，请联系红小宝客服：\(hxb.string.servicePhone)", font: hxb.font.light, textColor: hxb.color.important, numOfLines: 0)
}

// MARK: - UI
extension HXBMobileUnbindingController {
    fileprivate func setUI() {
        let nameTipLabel = UILabel(text: "", font: hxb.font.mainContent, textColor: hxb.color.important)
        nameTipLabel.attributedText = viewModel.nameTipAttributeString
        view.addSubview(nameTipLabel)
        
        idcardView.inputLengthLimit = hxb.size.idcardLength
        view.addSubview(idcardView)
        
        let mobileTipLabel = UILabel(text: "", font: hxb.font.mainContent, textColor: hxb.color.important)
        mobileTipLabel.attributedText = viewModel.mobileTipAttributeString
        view.addSubview(mobileTipLabel)
        
        getCodeBtn = UIButton(title: "获取验证码", font: hxb.font.light, titleColor: hxb.color.mostImport, target: viewModel, action: #selector(HXBMobileUnbindingViewModel.getCode))
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
        
        let showIdcard = viewModel.showIdcard
        
        nameTipLabel.snp.makeConstraints { maker in
            maker.top.equalTo(showIdcard ? 30 : 0)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            if showIdcard == false {
                maker.height.equalTo(0)
            }
        }
        
        idcardView.snp.makeConstraints { maker in
            maker.top.equalTo(nameTipLabel.snp.bottom).offset(showIdcard ? hxb.size.view2View : 0)
            maker.left.right.equalTo(nameTipLabel)
            maker.height.equalTo(showIdcard ? hxb.size.inputHeight : 0)
        }
        
        nameTipLabel.isHidden = !showIdcard
        idcardView.isHidden = !showIdcard
        
        mobileTipLabel.snp.makeConstraints { maker in
            maker.top.equalTo(idcardView.snp.bottom).offset(showIdcard ? hxb.size.view2View : 30)
            maker.left.right.equalTo(nameTipLabel)
        }
        
        codeView.snp.makeConstraints { maker in
            maker.top.equalTo(mobileTipLabel.snp.bottom).offset(hxb.size.view2View)
            maker.left.right.equalTo(idcardView)
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
        viewModel.timerSignal.observeValues { [weak self] time in
            let end = time == 0
            self?.getCodeBtn.isUserInteractionEnabled = end
            self?.getCodeBtn.setTitle(end ? "获取验证码" : "\(time)s", for: .normal)
            self?.getCodeBtn.setTitleColor(end ? hxb.color.mostImport : hxb.color.white, for: .normal)
            self?.getCodeBtn.backgroundColor = end ? hxb.color.white : hxb.color.sepLine
            self?.getCodeBtn.layer.borderColor = end ? hxb.color.mostImport.cgColor : UIColor.clear.cgColor
        }
        
        codeView.inputFieldSignal.map { $0.count >= hxb.size.msgCodeLength}.skipRepeats().combineLatest(with: idcardView.inputFieldSignal.map {$0.count == hxb.size.idcardLength }.skipRepeats()).map { $0 && $1}.observeValues { [weak self]  enabled in
            self?.nextBtn.isUserInteractionEnabled = enabled
            self?.nextBtn.backgroundColor = enabled ? hxb.color.mostImport : hxb.color.sepLine
        }
    }
}

// MARK: - Action
extension HXBMobileUnbindingController {
    
    @objc fileprivate func nextClick() {
        if viewModel.showIdcard && checkInput(inputView: idcardView, toastEmpty: "身份证号码不能为空", toastCount: "请输入18位身份证码", limitCount: 18, toastView: view) == false {
            return
        }
        if checkInput(inputView: codeView, toastEmpty: "短信验证码不能为空", toastCount: "请输入6位短信验证码", limitCount: 6, toastView: view) == false {
            return
        }
        let idNo = idcardView.text!.replacingOccurrences(of: " ", with: "")
        let code = codeView.text!.replacingOccurrences(of: " ", with: "")
        viewModel.checkIdentifySms(idNo: idNo, code: code) { isSuccess in
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
