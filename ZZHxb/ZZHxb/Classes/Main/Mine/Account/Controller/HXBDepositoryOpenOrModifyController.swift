//
//  HXBDepositoryOpenOrModifyController.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/2.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

/// 开通或修改存管账户
class HXBDepositoryOpenOrModifyController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    // MARK: - Public Property
    
    
    // MARK: - Private Property
    fileprivate let scrollView = UIScrollView()
    
    fileprivate let nameView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_name"), placeholder: "真实姓名", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate let idcardView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_idcard"), placeholder: "身份证号", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate let pwdView = HXBInputFieldView.eyeFieldView(leftImage: UIImage("input_password_blue"), placeholder: "请设置6位纯数字的交易密码", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate var bankView: HXBInputFieldView!
    
    fileprivate let phoneView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_phone_blue"), placeholder: "银行预留手机号", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate var agreeBtn: UIButton!
    fileprivate var bottomBtn: UIButton!
    fileprivate var protocolView: UIView!
}

// MARK: - UI
extension HXBDepositoryOpenOrModifyController {
    fileprivate func setUI() {
        title = "开通存管账户"
        navBgImage = UIImage("navigation_blue")!
        
        scrollView.frame = view.bounds
        scrollView.backgroundColor = hxb.color.background
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)
        
        let sectionView1 = viewTitle("安全认证", description: "按国家规定投资用户需满18岁")
        scrollView.addSubview(sectionView1)
        
        let sectionView2 = viewTitle("银行卡", description: "实名认证与银行卡需为同一人")
        scrollView.addSubview(sectionView2)
        
        let sectionHeight = 80
        let inputHeight = 50
        
        let topInputView = UIView()
        scrollView.addSubview(topInputView)
        
        topInputView.addSubview(nameView)
        topInputView.addSubview(idcardView)
        topInputView.addSubview(pwdView)

        let bottomInputView = UIView()
        scrollView.addSubview(bottomInputView)

        let btn = UIButton(title: "查看银行限额", font: hxb.font.transaction, titleColor: hxb.color.linkActivity, target: self, action: #selector(queryLimit))
        btn.frame.size = btn.currentTitle!.zz_size(withLimitSize: CGSize(width: 1000, height: 1000), fontSize: 14)
        bankView = HXBInputFieldView.rightClickViewFieldView(leftImage: UIImage("input_bank"), placeholder: "银行卡号", clickView: btn, leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)


        bottomBtn = UIButton(title: "开通恒丰银行存管账户", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: UIColor(red: 227, green: 191, blue: 128), target: self, action: #selector(createDepositoryAccount))
        view.addSubview(bottomBtn)

        protocolView = getProtocolView()
        scrollView.addSubview(protocolView)

        bottomInputView.addSubview(bankView)
        bottomInputView.addSubview(phoneView)
        
        idcardView.inputLengthLimit = 18
        pwdView.inputLengthLimit = 6
        bankView.inputLengthLimit = 20
        phoneView.inputLengthLimit = 11
        
        pwdView.rightView.isHighlighted = true
        
        pwdView.keyboardType = .numberPad
        bankView.keyboardType = .numberPad
        phoneView.keyboardType = .numberPad
        
        sectionView1.snp.makeConstraints { maker in
            maker.top.right.left.centerX.equalToSuperview()
            maker.height.equalTo(sectionHeight)
        }
        
        topInputView.snp.makeConstraints { maker in
            maker.top.equalTo(sectionView1.snp.bottom)
            maker.left.right.equalToSuperview()
        }

        nameView.snp.makeConstraints { maker in
            maker.top.right.left.equalToSuperview()
            maker.height.equalTo(inputHeight)
        }

        idcardView.snp.makeConstraints { maker in
            maker.top.equalTo(nameView.snp.bottom).offset(hxb.size.view2View)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(inputHeight)
        }

        pwdView.snp.makeConstraints { maker in
            maker.top.equalTo(idcardView.snp.bottom).offset(hxb.size.view2View)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(inputHeight)
            maker.bottom.equalToSuperview()
        }
        
        sectionView2.snp.makeConstraints { maker in
            maker.top.equalTo(topInputView.snp.bottom)
            maker.left.right.equalToSuperview()
            maker.height.equalTo(sectionHeight)
        }

        bottomInputView.snp.makeConstraints { maker in
            maker.top.equalTo(sectionView2.snp.bottom)
            maker.left.right.equalToSuperview()
        }

        bankView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(inputHeight)
        }

        phoneView.snp.makeConstraints { maker in
            maker.top.equalTo(bankView.snp.bottom).offset(hxb.size.view2View)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(inputHeight)
            maker.bottom.equalToSuperview()
        }

        bottomBtn.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.height.equalTo(hxb.size.tabbarHeight)
            maker.bottom.equalTo(-view.safeAreaInsets.bottom)
        }
        
        view.layoutIfNeeded()
        
        protocolView.snp.makeConstraints { maker in
            maker.top.equalTo(bottomInputView.snp.bottom).offset(protocolView.zz_y - bottomInputView.zz_maxY)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
        }
    }
}

// MARK: - Action
extension HXBDepositoryOpenOrModifyController {
    @objc fileprivate func queryLimit() {
        HXBNavigationController(rootViewController: HXBBankListController()).presentFrom(controller: self, animated: true)
    }
    
    @objc fileprivate func createDepositoryAccount() {
        
    }
    
    @objc fileprivate func agreeProtocolClick() {
        
    }
}

// MARK: - Network
extension HXBDepositoryOpenOrModifyController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBDepositoryOpenOrModifyController {
    fileprivate func viewTitle(_ title: String, description: String) -> UIView {
        let titleLabel = UILabel(text: "●  \(title)  ●", font: hxb.font.mainContent, textColor: hxb.color.linkActivity, textAlignment: .center)
        let descLabel = UILabel(text: description, font: hxb.font.light, textColor: hxb.color.light, textAlignment: .center)
        
        let view = UIView()
        
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(20)
            maker.centerX.left.right.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(-20)
            maker.centerX.left.right.equalToSuperview()
        }
        
        return view
    }
    
    fileprivate func getProtocolView() -> UIView {
        let protocolX = hxb.size.edgeScreen
        let protocolW = self.scrollView.frame.width - protocolX * 2
        let protocolH: CGFloat = 34
        // 这个高度真不理解
        let protocolY = self.scrollView.frame.height - hxb.size.bottomAddtionHeight - hxb.size.tabbarHeight - protocolH - hxb.size.view2View - hxb.size.navigationHeight
        
        let view = UIView(frame: CGRect(x: protocolX, y: protocolY, width: protocolW, height: protocolH))
        
        agreeBtn = UIButton(imageName: "depository_protocol_disagree", selectedImageName: "depository_protocol_agree", target: self, action: #selector(agreeProtocolClick))
        agreeBtn.isSelected = true
        
        let protocolString1 = "《红小宝平台授权协议》"
        let protocolString2 = "《恒丰银行股份有限公司杭州分行网络交易资金账户三方协议》"
        let protocolLabel = ActiveLabel(text: "我已查看并同意\(protocolString1),\(protocolString2)", font: hxb.font.light, textColor: hxb.color.important, numOfLines: 0)
        
        let customType = ActiveType.custom(pattern: "\(protocolString1)|\(protocolString2)")
        protocolLabel.enabledTypes.append(customType)
        
        protocolLabel.customize { label in
            label.lineSpacing = 4
            label.customColor[customType] = hxb.color.linkActivity
            label.handleCustomTap(for: customType) { string in
                if string == protocolString1 {
                    
                } else if string == protocolString2 {
                    
                }
            }
        }

        view.addSubview(agreeBtn)
        view.addSubview(protocolLabel)
        
        agreeBtn.snp.makeConstraints { maker in
            maker.top.left.equalToSuperview().offset(2)
            maker.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        protocolLabel.snp.makeConstraints { maker in
            maker.left.equalTo(agreeBtn.snp.right).offset(8)
            maker.top.right.bottom.equalToSuperview()
        }
        
        return view
    }
}

// MARK: - Other
extension HXBDepositoryOpenOrModifyController {
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        bottomBtn.snp.updateConstraints { maker in
            maker.bottom.equalTo(-view.safeAreaInsets.bottom)
        }
    }
}

// MARK: - Public
extension HXBDepositoryOpenOrModifyController {
    
}

