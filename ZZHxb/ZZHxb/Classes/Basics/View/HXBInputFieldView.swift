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
    
    var text: String? = nil {
        didSet {
            textField.text = text
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
    
    var leftPadding = 0 {
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
    
    var rightPadding = 0 {
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

// MARK: - Other
extension HXBInputFieldView {
    @objc private func tapEye() {
        rightView.isHighlighted = !rightView.isHighlighted
        textField.isSecureTextEntry = rightView.isHighlighted
    }
}

// MARK: - Public
extension HXBInputFieldView {
    static func eyeFieldView(leftImage: UIImage?, text: String? = nil, placeholder: String?) -> HXBInputFieldView {
        let fieldView = HXBInputFieldView.commonFieldView(leftImage: leftImage, text: text, placeholder: placeholder)
        
        fieldView.hasRightView = true
        fieldView.rightView.isUserInteractionEnabled = true
        fieldView.rightImage = UIImage("input_eye_open")
        fieldView.rightSelectedImage = UIImage("input_eye_closed")
        fieldView.rightPadding = 0
        fieldView.right2InputViewPadding = 10
        
        fieldView.rightView.addGestureRecognizer(UITapGestureRecognizer(target: fieldView, action: #selector(tapEye)))
        
        return fieldView
    }
    
    static func commonFieldView(leftImage: UIImage?, text: String? = nil, placeholder: String?) -> HXBInputFieldView {
        let fieldView = HXBInputFieldView()
        fieldView.leftImage = leftImage
        fieldView.text = text
        fieldView.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: hxb.color.light])
        fieldView.hasRightView = false
        return fieldView
    }
}
