//
//  HXBDepositoryCheckViewController.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/2.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

/// 开通存管账户的检查提示页面
class HXBDepositoryCheckViewController: HXBViewController {

    // MARK: - Life Cycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Public Property
    
    /// 点击了打开按钮
    var openClosure: (() -> ())?
    
    // MARK: - Private Property
    fileprivate let contentView = UIView()
    fileprivate let iconView = UIImageView(named: "depository_check_pic")
    fileprivate let textLabel = UILabel(text: "红小宝与恒丰银行完成对接\n用户资金有效隔离", font: hxb.font.transaction, textColor: hxb.color.light, numOfLines: 0, textAlignment: .center)
    fileprivate let openBtn = UIButton(title: "立即开通恒丰银行存管账户", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: UIColor(red: 227, green: 191, blue: 128), target: self, action: #selector(clickOpen))
    fileprivate let closeBtn = UIButton(imageName: "circle_white_close", hilightedImageName: "circle_white_close", target: self, action: #selector(clickClose))
}

// MARK: - UI
extension HXBDepositoryCheckViewController {
    fileprivate func setUI() {
        view.backgroundColor = hxb.color.alphaBackgroundColor
        
        view.addSubview(contentView)
        contentView.addSubview(iconView)
        contentView.addSubview(textLabel)
        contentView.addSubview(openBtn)
        
        contentView.backgroundColor = hxb.color.white
        openBtn.layer.cornerRadius = 8
        openBtn.layer.masksToBounds = true
        
        view.addSubview(closeBtn)
        
        contentView.snp.makeConstraints { maker in
            maker.left.equalTo(40)
            maker.right.equalTo(-40)
            maker.centerY.equalToSuperview().offset(-30)
            maker.height.equalTo(324)
        }
        
        iconView.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.left.equalTo(10)
            maker.right.equalToSuperview()
            maker.height.equalTo(186)
        }
        
        textLabel.snp.makeConstraints { maker in
            maker.top.equalTo(iconView.snp.bottom).offset(15)
            maker.centerX.equalToSuperview()
        }
        
        openBtn.snp.makeConstraints { maker in
            maker.left.equalTo(30)
            maker.right.equalTo(-30)
            maker.height.equalTo(36)
            maker.bottom.equalTo(-30)
        }
        
        closeBtn.snp.makeConstraints { maker in
            maker.width.height.equalTo(30)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(contentView.snp.bottom).offset(60)
        }
    }
}

// MARK: - Action
extension HXBDepositoryCheckViewController {
    @objc fileprivate func clickOpen() {
        self.openClosure?()
    }
    
    @objc fileprivate func clickClose() {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - Network
extension HXBDepositoryCheckViewController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBDepositoryCheckViewController {
    
}

// MARK: - Other
extension HXBDepositoryCheckViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - Public
extension HXBDepositoryCheckViewController {
    
}

