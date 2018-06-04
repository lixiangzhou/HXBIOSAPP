//
//  HXBCaptchaValidateView.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/3.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBCaptchaValidateView: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        getCaptcha()
    }

    // MARK: - Public Property
    // MARK: - Private Property
    fileprivate let containerView = UIView()
    fileprivate let titleLabel = UILabel(text: "请输入下面的图形验证码", font: hxb.font.mainContent, textColor: hxb.color.important, textAlignment: .center)
    fileprivate let inputField = UITextField()
    fileprivate let captchaView = UIImageView()
    fileprivate let confirmBtn = UIButton(title: "确定", font: hxb.font.mainContent, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport)
    fileprivate let cancelBtn = UIButton(title: "取消", font: hxb.font.mainContent, titleColor: hxb.color.light, backgroundColor: hxb.color.alertCancelBtn)
    
    fileprivate var confirmClosure: ((String?) -> Void)?
    private let viewModel = HXBSignUpViewModel()
}

// MARK: - UI
extension HXBCaptchaValidateView {
    fileprivate func setUI() {
        backgroundColor = hxb.color.alphaBackgroundColor

        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = hxb.color.white
        
        captchaView.contentMode = .scaleAspectFit
        captchaView.isUserInteractionEnabled = true
        captchaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getCaptcha)))
        
        inputField.clearButtonMode = .whileEditing
        inputField.delegate = self
        
        let lineView = UIView()
        lineView.backgroundColor = hxb.color.mostImport
        
        let centerView = UIView()
        centerView.addSubview(inputField)
        centerView.addSubview(captchaView)
        centerView.addSubview(lineView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(centerView)
        containerView.addSubview(cancelBtn)
        containerView.addSubview(confirmBtn)
        
        addSubview(containerView)
        
        cancelBtn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        confirmBtn.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        containerView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(-60)
            maker.width.equalTo(adaptDecimal(280))
            maker.height.equalTo(adaptDecimal(200))
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(hxb.size.edgeScreen * 2)
            maker.right.left.equalToSuperview()
        }
        
        centerView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints { maker in
            maker.left.bottom.equalToSuperview()
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
        
        confirmBtn.snp.makeConstraints { maker in
            maker.right.bottom.equalToSuperview()
            maker.left.equalTo(cancelBtn.snp.right)
            maker.height.width.equalTo(cancelBtn)
        }
        
        inputField.snp.makeConstraints { maker in
            maker.left.centerY.equalToSuperview()
            maker.width.equalTo(80)
            maker.height.equalTo(hxb.size.normalButtonHeight)
        }
        
        lineView.snp.makeConstraints { maker in
            maker.right.left.bottom.equalTo(inputField)
            maker.height.equalTo(hxb.size.sepLineWidth)
        }
        
        captchaView.snp.makeConstraints { maker in
            maker.top.right.bottom.equalToSuperview()
            maker.width.equalTo(inputField)
            maker.left.equalTo(inputField.snp.right).offset(hxb.size.view2View)
            maker.height.equalTo(hxb.size.normalButtonHeight * 2.4)
        }
        
    }
}

// MARK: - Action
extension HXBCaptchaValidateView {
    @objc fileprivate func cancel() {
        removeFromSuperview()
    }
    
    @objc fileprivate func confirm() {
        let code = inputField.text ?? ""
        viewModel.validateCaptcha(code) { isSuccess in
            if isSuccess {
                self.confirmClosure?(code)
                self.cancel()
            } else {
                self.inputField.text = ""
            }
        }
    }
}

// MARK: - Delegate
 extension HXBCaptchaValidateView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length > 0 && string.isEmpty { // 删除
            
        } else {    // 输入文字
            var text = textField.text ?? ""
            text += string
            if text.count > 4 {
                return false
            }
        }
        
        return true
    }
}

// MARK: - Other
extension HXBCaptchaValidateView {
    @objc fileprivate func getCaptcha() {
        viewModel.getCaptcha { isSuccess, data in
            if let data = data {
                self.captchaView.image = UIImage(data: data)
            }
        }
    }
}

// MARK: - Public
extension HXBCaptchaValidateView {
    static func show(fromView: UIView = UIApplication.shared.keyWindow!, comfirmClosure: @escaping (String?) -> Void) {
        let validateView = HXBCaptchaValidateView()
        validateView.frame = UIApplication.shared.keyWindow!.frame
        validateView.confirmClosure = comfirmClosure
        fromView.addSubview(validateView)
    }
}
