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
    fileprivate let cancelBtn = UIButton(imageName: "alert_close", hilightedImageName: "alert_close", backgroundColor: hxb.color.white)
    
    fileprivate var confirmClosure: ((String?) -> Void)?
    private let viewModel = HXBSignUpViewModel()
}

// MARK: - UI
extension HXBCaptchaValidateView {
    fileprivate func setUI() {
        backgroundColor = UIColor.init(white: 0.5, alpha: 0.8)

        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = hxb.color.white
        
        confirmBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        confirmBtn.layer.masksToBounds = true
        
        cancelBtn.layer.cornerRadius = 25 * 0.5
        cancelBtn.layer.masksToBounds = true
        
        captchaView.contentMode = .scaleAspectFit
        captchaView.isUserInteractionEnabled = true
        captchaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getCaptcha)))
        
        let centerView = UIView()
        centerView.addSubview(inputField)
        centerView.addSubview(captchaView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(centerView)
        containerView.addSubview(confirmBtn)
        
        let sepLine = UIView()
        sepLine.backgroundColor = hxb.color.white
        
        addSubview(sepLine)
        addSubview(containerView)
        addSubview(cancelBtn)
        
        cancelBtn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        confirmBtn.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        containerView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().offset(-40)
            maker.width.equalTo(adaptDecimal(280))
            maker.height.equalTo(adaptDecimal(200))
        }
        
        cancelBtn.snp.makeConstraints { maker in
            maker.right.equalTo(containerView)
            maker.bottom.equalTo(containerView.snp.top).offset(-35)
            maker.width.height.equalTo(25)
        }
        
        sepLine.snp.makeConstraints { maker in
            maker.top.equalTo(cancelBtn.snp.bottom).offset(-5)
            maker.bottom.equalTo(containerView.snp.top).offset(5)
            maker.centerX.equalTo(cancelBtn)
            maker.width.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(hxb.size.edgeScreen * 2)
            maker.right.left.equalToSuperview()
        }
        
        centerView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        
        confirmBtn.snp.makeConstraints { maker in
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.bottom.equalTo(-hxb.size.edgeScreen * 2)
            maker.height.equalTo(hxb.size.normalButtonHeight)
        }
        
        inputField.snp.makeConstraints { maker in
            maker.top.left.bottom.equalToSuperview()
            maker.width.equalTo(80)
            maker.height.equalTo(hxb.size.normalButtonHeight * 2)
        }
        
        captchaView.snp.makeConstraints { maker in
            maker.top.right.bottom.equalToSuperview()
            maker.width.equalTo(inputField)
            maker.left.equalTo(inputField.snp.right).offset(hxb.size.view2View)
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

// MARK: - Helper
extension HXBCaptchaValidateView {
    
}

// MARK: - Other
extension HXBCaptchaValidateView {
    @objc fileprivate func getCaptcha() {
        viewModel.getCaptcha { (isSuccess, data) in
            if let data = data {
                self.captchaView.image = UIImage(data: data)
            }
        }
    }
}

// MARK: - Public
extension HXBCaptchaValidateView {
    static func showFrom(view: UIView = UIApplication.shared.keyWindow!, comfirmClosure: @escaping (String?) -> Void) {
        let validateView = HXBCaptchaValidateView()
        validateView.frame = UIApplication.shared.keyWindow!.frame
        validateView.confirmClosure = comfirmClosure
        view.addSubview(validateView)
    }
}
