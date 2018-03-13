//
//  HXBDepositoryOpenOrModifyController.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/2.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

fileprivate let bankNoMinCount = 12
fileprivate let inputHeight = 50

/// 开通或修改存管账户
class HXBDepositoryOpenOrModifyController: HXBViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "开通存管账户"
        setUI()
        setBindings()
        setData()
    }
    
    deinit {
        print("HXBDepositoryOpenOrModifyController deinit")
    }
    
    // MARK: - Public Property
    
    
    // MARK: - Private Property
    fileprivate let scrollView = UIScrollView()
    
    fileprivate let nameView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_name"), placeholder: "真实姓名", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate let idcardView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_idcard"), placeholder: "身份证号", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate let pwdView = HXBInputFieldView.eyeFieldView(leftImage: UIImage("input_password_blue"), placeholder: "请设置6位纯数字的交易密码", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate var bankNoView: HXBInputFieldView!
    fileprivate var bankInfoView = HXBInputFieldView.commonFieldView(leftImage: UIImage("default_bank"), placeholder: "", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate let phoneView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_phone_blue"), placeholder: "银行预留手机号", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate var agreeBtn: UIButton!
    fileprivate var bottomBtn: UIButton!
    fileprivate var protocolView: UIView!
    
    fileprivate let viewModel = HXBDepositoryOpenOrModifyViewModel()
    
    fileprivate var bankInfoShowSignal: Signal<Bool, NoError>!
}

// MARK: - UI
extension HXBDepositoryOpenOrModifyController {
    fileprivate func setUI() {
        navBgImage = UIImage("navigation_blue")!
        
        scrollView.frame = view.bounds
        scrollView.backgroundColor = hxb.color.background
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        
        scrollView.header = ZZRefreshHeader(target: self, action: #selector(updateDepositoryInfo))
        
        let sectionView1 = viewTitle("安全认证", description: "按国家规定投资用户需满18岁")
        scrollView.addSubview(sectionView1)
        
        let sectionView2 = viewTitle("银行卡", description: "实名认证与银行卡需为同一人")
        scrollView.addSubview(sectionView2)
        
        let sectionHeight = 80
        
        let topInputView = UIView()
        scrollView.addSubview(topInputView)
        
        topInputView.addSubview(nameView)
        topInputView.addSubview(idcardView)
        topInputView.addSubview(pwdView)
        
        let bottomInputView = UIView()
        scrollView.addSubview(bottomInputView)
        
        let btn = UIButton(title: "查看银行限额", font: hxb.font.transaction, titleColor: hxb.color.linkActivity, target: self, action: #selector(queryLimit))
        btn.frame.size = btn.currentTitle!.zz_size(withLimitSize: CGSize(width: 1000, height: 1000), fontSize: 14)
        bankNoView = HXBInputFieldView.rightClickViewFieldView(leftImage: UIImage("input_bank"), placeholder: "银行卡号", clickView: btn, leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: hxb.color.sepLine)
        bankNoView.bankNoMode = true
        
        bankNoView.inputViewChangeClosure = { [weak self] textField in
            if let text = textField.text?.replacingOccurrences(of: " ", with: ""),
                text.count >= bankNoMinCount {
                self?.checkBankNo(text)
            }
        }
        
        bottomBtn = UIButton(title: "开通恒丰银行存管账户", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: UIColor(red: 227, green: 191, blue: 128), target: self, action: #selector(createDepositoryAccount))
        view.addSubview(bottomBtn)
        
        protocolView = getProtocolView()
        scrollView.addSubview(protocolView)
        
        bottomInputView.addSubview(bankNoView)
        bottomInputView.addSubview(bankInfoView)
        bottomInputView.addSubview(phoneView)
        
        idcardView.inputLengthLimit = 18
        pwdView.inputLengthLimit = 6
        bankNoView.inputLengthLimit = 24
        phoneView.inputLengthLimit = 11
        
        pwdView.rightView.isHighlighted = true
        bankInfoView.editEnabled = false
        bankInfoView.leftViewSize = CGSize(width: 15, height: 15)
        bankInfoView.alpha = 0
        bankInfoView.textColor = hxb.color.light
        bankNoView.hideBottomLine = true
        
        pwdView.keyboardType = .numberPad
        bankNoView.keyboardType = .numberPad
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
        
        bankNoView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(inputHeight)
        }
        
        bankInfoView.snp.makeConstraints { maker in
            maker.top.equalTo(bankNoView.snp.bottom)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(0)
        }
        
        phoneView.snp.makeConstraints { maker in
            maker.top.equalTo(bankInfoView.snp.bottom).offset(hxb.size.view2View)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(inputHeight)
            maker.bottom.equalToSuperview()
        }
        
        bottomBtn.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.height.equalTo(hxb.size.tabbarHeight)
            maker.bottom.equalTo(-view.safeAreaInsets.bottom)
        }
    }
    
    fileprivate func setBindings() {
        bankInfoShowSignal = bankNoView.inputFieldSignal.map { $0.replacingOccurrences(of: " ", with: "").count >= bankNoMinCount }
        
        viewModel.bankCardSignal.producer.combineLatest(with: bankInfoShowSignal).map { ($0, $1 && $0.bankName.count > 0 && $0.bankCode.count > 0 && $0.quota.count > 0) }.startWithValues {[weak self] (bank, needShow) in
            self?.updateBankViews(bank: bank, needShow: needShow, update: false)
        }
        
        bottomBtn.reactive.title <~ HXBAccountViewModel.shared.depositoryOpenSignal.map { $0 ? "提交" : "开通恒丰银行存管账户" }
        
        viewModel.updateBankInfoSignal.map { ($0, $0.bankCode.count > 0) }.observeValues { [weak self] bank, needShow in
            self?.updateBankViews(bank: bank, needShow: needShow, update: true)
        }
    }
    
    fileprivate func setData() {
        let account = HXBAccountViewModel.shared.account
        
        nameView.text = account.userInfo.realName
        idcardView.text = account.userInfo.idNo
    }
}

// MARK: - Action
extension HXBDepositoryOpenOrModifyController {
    @objc fileprivate func queryLimit() {
        HXBNavigationController(rootViewController: HXBBankListController()).presentFrom(controller: self, animated: true)
    }
    
    @objc fileprivate func createDepositoryAccount() {
        guard checkInputsValidate() else {
            return
        }
        
        var param = [String: String]()
        param["realName"] = nameView.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        param["identityCard"] = idcardView.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        param["password"] = pwdView.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        param["bankCard"] = bankNoView.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        param["bankReservedMobile"] = phoneView.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        viewModel.bankCardSignal.observeValues { value in
            
        }
    }
    
    @objc fileprivate func agreeProtocolClick() {
        
    }
}

// MARK: - Network
extension HXBDepositoryOpenOrModifyController {
    @objc fileprivate func updateDepositoryInfo() {
        viewModel.updateDepositoryInfo { [weak self] in
            self?.scrollView.header?.endRefreshing()
            self?.setData()
        }
    }
}

// MARK: - Helper
extension HXBDepositoryOpenOrModifyController {
    fileprivate func checkInputsValidate() -> Bool {
        
        func checkInput(inputView: HXBInputFieldView, toastEmpty: String, toastCount: String, limitCount: Int = 0, min: Int = 0, max: Int = 0) -> Bool {
            let text = inputView.text ?? ""
            if text.isEmpty {
                HXBHUD.show(toast: toastEmpty, in: view)
                return false
            }
            if limitCount > 0 { //  具体的限制
                if text.count != limitCount {
                    HXBHUD.show(toast: toastCount, in: view)
                    return false
                }
                return true
            } else {    // 范围限制
                if text.count >= min && text.count <= max {
                    return true
                }
                HXBHUD.show(toast: toastCount, in: view)
                return false
            }
        }
        
        if (nameView.text ?? "").isEmpty {
            HXBHUD.show(toast: "真实姓名不能为空", in: view)
            return false
        }
        
        guard checkInput(inputView: idcardView, toastEmpty: "身份证号不能为空", toastCount: "身份证号输入有误", limitCount: 18),
        checkInput(inputView: pwdView, toastEmpty: "交易密码不能为空", toastCount: "交易密码为6位数字", limitCount: 6),
        checkInput(inputView: bankNoView, toastEmpty: "银行卡号不能为空", toastCount: "银行卡号输入有误", min: 10, max: 31),
        checkInput(inputView: phoneView, toastEmpty: "预留手机号不能为空", toastCount: "预留手机号有误", limitCount: 11) else {
            return false
        }
        return true
    }
    
    fileprivate func checkBankNo(_ bankNo: String) {
        viewModel.checkBankNo(bankNo)
    }
    
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
        let view = UIView(frame: getProtocolFrame())
        
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
                var url = ""
                if string == protocolString1 {
                    url = hxb.api.authorize
                } else if string == protocolString2 {
                    url = hxb.api.thirdpard
                }
                HXBWebController(urlString: url).pushFrom(controller: self, animated: true)
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
    
    fileprivate func getProtocolFrame() -> CGRect {
        let protocolX = hxb.size.edgeScreen
        let protocolW = self.scrollView.frame.width - protocolX * 2
        let protocolH: CGFloat = 34
        // 这个高度真不理解
        let protocolY = self.scrollView.frame.height - hxb.size.bottomAddtionHeight - hxb.size.tabbarHeight - protocolH - hxb.size.view2View - hxb.size.navigationHeight
        return CGRect(x: protocolX, y: protocolY, width: protocolW, height: protocolH)
    }
    
    ///   - update: 是否是更新，false: 仅设置数据；true：更新数据
    fileprivate func updateBankViews(bank: HXBBankCardBinModel, needShow: Bool, update: Bool) {
        let height = needShow ? inputHeight : 0
        bankInfoView.snp.updateConstraints({ maker in
            maker.height.equalTo(height)
        })
        
        bankNoView.hideBottomLine = !needShow
        bankInfoView.leftImage = UIImage(bank.bankCode) ?? UIImage("default_bank")
        bankInfoView.leftViewSize = CGSize(width: 15, height: 15)
        bankInfoView.text = update ? bank.bankType + bank.quota : bank.bankName + "：" + bank.quota
        if update {
            bankNoView.text = bank.cardId
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
            self.bankInfoView.alpha = needShow ? 1 : 0
            self.protocolView.frame = self.getProtocolFrame()
        })
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

