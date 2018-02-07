//
//  HXBInputFieldView.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/20.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBInputFieldView: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    var hideTopLine = true {
        didSet {
            topLine.isHidden = hideTopLine
        }
    }
    
    var hideBottomLine = false {
        didSet {
            bottomLine.isHidden = hideBottomLine
        }
    }
    
    var topLineColor = UIColor.clear {
        didSet {
            topLine.backgroundColor = topLineColor
        }
    }
    
    var bottomLineColor = UIColor.clear {
        didSet {
            bottomLine.backgroundColor = bottomLineColor
        }
    }
    
    var text: String? {
        set {
            textField.text = text
        }
        get {
            return textField.text
        }
    }
    
    var textColor = hxb.color.important {
        didSet {
            textField.textColor = textColor
        }
    }
    
    var textFont = hxb.font.mainContent {
        didSet {
            textField.font = textFont
        }
    }
    
    var placeholder: String? = "占位文字" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        didSet {
            textField.attributedPlaceholder = attributedPlaceholder
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var isSecureTextEntry: Bool = true {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var leftImage: UIImage? {
        didSet {
            leftView.image = leftImage
            if let leftImage = leftImage {
                leftViewSize = leftImage.size
            }
        }
    }
    
    var rightImage: UIImage? {
        didSet {
            rightView.image = rightImage
            if let rightImage = rightImage {
                rightViewSize = rightImage.size
            }
        }
    }
    
    var rightSelectedImage: UIImage? {
        didSet {
            rightView.highlightedImage = rightSelectedImage
        }
    }
    
    var hasRightView = false {
        didSet {
            if hasRightView == false {
                rightPadding = 0
                rightViewSize = CGSize.zero
                right2InputViewPadding = 0
            }
            
            rightView.isHidden = !hasRightView
        }
    }
    
    var leftViewSize = CGSize(width: 30, height: 30) {
        didSet {
            if leftView.superview != nil {
                leftView.snp.updateConstraints({ (maker) in
                    maker.size.equalTo(leftViewSize)
                })
            }
        }
    }
    
    var leftPadding: CGFloat = 0 {
        didSet {
            if leftView.superview != nil {
                leftView.snp.updateConstraints({ (maker) in
                    maker.left.equalTo(leftPadding)
                })
            }
        }
    }
    
    /// leftView 和 textField 的间距
    var left2InputViewPadding = 12 {
        didSet {
            if leftView.superview != nil {
                leftView.snp.updateConstraints({ (maker) in
                    maker.right.equalTo(textField.snp.left).offset(-left2InputViewPadding)
                })
            }
        }
    }
    
    var rightViewSize = CGSize(width: 0, height: 0) {
        didSet {
            if rightView.superview != nil {
                rightView.snp.updateConstraints({ (maker) in
                    maker.size.equalTo(rightViewSize)
                })
            }
        }
    }
    
    var rightPadding: CGFloat = 0 {
        didSet {
            if rightView.superview != nil {
                rightView.snp.updateConstraints({ (maker) in
                    maker.right.equalTo(rightPadding)
                })
            }
        }
    }
    
    /// rightView 和 textField 的间距
    var right2InputViewPadding = 10 {
        didSet {
            if rightView.superview != nil {
                rightView.snp.updateConstraints({ (maker) in
                    maker.left.equalTo(textField.snp.right).offset(right2InputViewPadding)
                })
            }
        }
    }
    
    var inputLengthLimit = Int.max
    
    var inputViewChangeClosure:((UITextField) -> Void)?
    
    // MARK: - Private Property
    fileprivate let leftView = UIImageView()
    let rightView = UIImageView()
    
    fileprivate let textField = UITextField()
    //    fileprivate let deleteView = UIImageView()
    
    fileprivate let topLine = UIView.sepLine()
    fileprivate let bottomLine = UIView.sepLine()
}

// MARK: - UI
extension HXBInputFieldView {
    fileprivate func setUI() {
        textField.delegate = self
        textField.reactive.controlEvents(.editingChanged).observeResult { result in
            if let field = result.value {
                self.inputViewChangeClosure?(field)
            }
        }
        
        addSubview(textField)
        addSubview(leftView)
        addSubview(rightView)
        //        addSubview(deleteView)
        addSubview(topLine)
        addSubview(bottomLine)
        
        leftView.contentMode = .scaleAspectFit
        rightView.contentMode = .scaleAspectFit
        textField.clearButtonMode = .whileEditing
        
        topLine.isHidden = hideTopLine
        bottomLine.isHidden = hideBottomLine
        topLine.backgroundColor = topLineColor
        bottomLine.backgroundColor = bottomLineColor
        textField.textColor = textColor
        textField.text = text
        textField.placeholder = placeholder
        textField.attributedText = attributedPlaceholder
        textField.keyboardType = keyboardType
        leftView.image = leftImage
        rightView.image = rightImage
        rightView.highlightedImage = rightSelectedImage
        
        leftView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(leftPadding)
            maker.right.equalTo(textField.snp.left).offset(-left2InputViewPadding)
            maker.size.equalTo(leftViewSize)
        }
        
        textField.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(textField.snp.right).offset(right2InputViewPadding)
            maker.right.equalToSuperview().offset(rightPadding)
            maker.size.equalTo(rightViewSize)
        }
        
        topLine.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(hxb.size.sepLineHeight)
        }
        
        bottomLine.snp.makeConstraints { (maker) in
            maker.left.bottom.right.equalToSuperview()
            maker.height.equalTo(hxb.size.sepLineHeight)
        }
    }
}

// MARK: - Action
extension HXBInputFieldView {
    
}

// MARK: - Helper
extension HXBInputFieldView {
    
}

// MARK: - Delegate
extension HXBInputFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.length > 0 && string.isEmpty { // 删除
            
        } else {    // 输入文字
            var text = textField.text ?? ""
            text += string
            if text.count > inputLengthLimit {
                return false
            }
        }
        
        return true
    }
}

// MARK: - Other
extension HXBInputFieldView {
    @objc private func tapEye() {
        rightView.isHighlighted = !rightView.isHighlighted
        self.isSecureTextEntry = rightView.isHighlighted
    }
}

// MARK: - Public
extension HXBInputFieldView {
    static func eyeFieldView(leftImage: UIImage?, text: String? = nil, placeholder: String?, leftSpacing: CGFloat = 0, rightSpacing: CGFloat = 0, bottomLineColor: UIColor = hxb.color.mostImport) -> HXBInputFieldView {
        let fieldView = HXBInputFieldView.commonFieldView(leftImage: leftImage, text: text, placeholder: placeholder, leftSpacing: leftSpacing, rightSpacing: rightSpacing, bottomLineColor: bottomLineColor)
        
        fieldView.hasRightView = true
        fieldView.rightView.isUserInteractionEnabled = true
        fieldView.rightImage = UIImage("input_eye_open")
        fieldView.rightSelectedImage = UIImage("input_eye_closed")
        fieldView.right2InputViewPadding = 10
        fieldView.isSecureTextEntry = true
        
        fieldView.rightView.addGestureRecognizer(UITapGestureRecognizer(target: fieldView, action: #selector(tapEye)))
        
        return fieldView
    }
    
    static func commonFieldView(leftImage: UIImage?, text: String? = nil, font: UIFont = hxb.font.mainContent, placeholder: String?, leftSpacing: CGFloat = 0, rightSpacing: CGFloat = 0, bottomLineColor: UIColor = hxb.color.mostImport) -> HXBInputFieldView {
        let fieldView = HXBInputFieldView()
        fieldView.backgroundColor = hxb.color.white
        fieldView.leftImage = leftImage
        fieldView.text = text
        fieldView.textFont = font
        fieldView.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: hxb.color.light])
        fieldView.hasRightView = false
        fieldView.bottomLineColor = bottomLineColor
        fieldView.leftPadding = leftSpacing
        fieldView.rightPadding = -rightSpacing
        
        return fieldView
    }
    
    static func smsOrVoiceValidFieldView(leftImage: UIImage?, text: String? = nil, placeholder: String?, leftSpacing: CGFloat = 0, rightSpacing: CGFloat = 0, bottomLineColor: UIColor = hxb.color.mostImport) -> (HXBInputFieldView, UIButton) {
        let voiceBtn = UIButton(title: "语音验证码", font: hxb.font.transaction, titleColor: hxb.color.mostImport)
        voiceBtn.layer.borderColor = hxb.color.mostImport.cgColor
        voiceBtn.layer.borderWidth = hxb.size.sepLineHeight
        voiceBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        voiceBtn.frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 30))
        
        let fieldView = HXBInputFieldView.rightClickViewFieldView(leftImage: leftImage, placeholder: placeholder, clickView: voiceBtn, leftSpacing: leftSpacing, rightSpacing: rightSpacing, bottomLineColor: bottomLineColor)
        return (fieldView, voiceBtn)
    }
    
    static func rightClickViewFieldView(leftImage: UIImage?, text: String? = nil, placeholder: String?, clickView: UIButton, leftSpacing: CGFloat = 0, rightSpacing: CGFloat = 0, bottomLineColor: UIColor = hxb.color.mostImport) -> HXBInputFieldView {
        let fieldView = HXBInputFieldView.commonFieldView(leftImage: leftImage, text: text, placeholder: placeholder, leftSpacing: leftSpacing, rightSpacing: rightSpacing, bottomLineColor: bottomLineColor)
        
        fieldView.hasRightView = true
        fieldView.rightView.isUserInteractionEnabled = true
        fieldView.rightViewSize = clickView.zz_size
        fieldView.right2InputViewPadding = 10
        
        fieldView.rightView.addSubview(clickView)
        return fieldView
    }
}
