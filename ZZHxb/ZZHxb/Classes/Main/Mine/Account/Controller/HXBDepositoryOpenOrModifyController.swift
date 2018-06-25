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
import XZLib

fileprivate let bankNoMinCount = 12
fileprivate let inputHeight = 50

/// 开通或修改存管账户
class HXBDepositoryOpenOrModifyController: HXBViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "开通存管账户"

        viewModel = HXBDepositoryOpenOrModifyViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
        setBindings()
        setData()
    }
    
    deinit {
        print("HXBDepositoryOpenOrModifyController deinit")
    }
    
    // MARK: - Public Property
    
    
    // MARK: - Private Property
    fileprivate var viewModel: HXBDepositoryOpenOrModifyViewModel!
    
    fileprivate let scrollView = UIScrollView()
    
    fileprivate let nameView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_name"), placeholder: "请输入真实姓名", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: hxb.color.sepLine)
    
    fileprivate let idcardView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_idcard"), placeholder: "请输入身份证号码", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: hxb.color.sepLine)
    
    fileprivate var bankNoView: HXBInputFieldView!
    fileprivate var bankInfoView = HXBInputFieldView.commonFieldView(leftImage: UIImage("default_bank"), placeholder: "", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: hxb.color.sepLine)
    
    fileprivate var bottomBtn: UIButton!
    
    fileprivate var bankInfoShowSignal: Signal<Bool, NoError>!
}

// MARK: - UI
extension HXBDepositoryOpenOrModifyController {
    fileprivate func setUI() {
        navBgImage = UIImage("navigation_blue")!
        
        scrollView.frame = view.bounds
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        
        scrollView.header = ZZRefreshHeader(target: self, action: #selector(updateDepositoryInfo))
        
        let sectionView1 = viewTitle("安全认证", description: "按国家规定投资用户需满18岁")
        scrollView.addSubview(sectionView1)
        
        let sectionView2 = viewTitle("银行卡", description: "实名认证与银行卡需为同一人")
        scrollView.addSubview(sectionView2)
        
        let sectionHeight = 100
        
        let topInputView = UIView()
        scrollView.addSubview(topInputView)
        
        
        topInputView.addSubview(nameView)
        topInputView.addSubview(idcardView)
        
        let bottomInputView = UIView()
        scrollView.addSubview(bottomInputView)
        
        let btn = UIButton(title: "查看银行限额", font: hxb.font.transaction, titleColor: hxb.color.linkActivity, target: self, action: #selector(bankList))
        btn.frame.size = btn.currentTitle!.zz_size(withLimitSize: CGSize(width: 1000, height: 1000), fontSize: 14)
        bankNoView = HXBInputFieldView.rightClickViewFieldView(leftImage: UIImage("input_bank"), placeholder: "银行卡号", clickView: btn, leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: hxb.color.sepLine)
        bankNoView.bankNoMode = true
        
        bankNoView.inputViewChangeClosure = { [weak self] textField in
            if let text = textField.text?.replacingOccurrences(of: " ", with: ""),
                text.count >= hxb.size.bankNoMinCount {
                self?.checkBankNo(text)
            }
        }
        
        bottomBtn = UIButton(title: "开通恒丰银行存管账户", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: UIColor(red: 227, green: 191, blue: 128), target: self, action: #selector(createDepositoryAccount))
        bottomBtn.layer.masksToBounds = true
        bottomBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        view.addSubview(bottomBtn)
        
        bottomInputView.addSubview(bankNoView)
        bottomInputView.addSubview(bankInfoView)
        
        idcardView.inputLengthLimit = hxb.size.idcardLength
        
        bankInfoView.editEnabled = false
        bankInfoView.leftViewSize = CGSize(width: 15, height: 15)
        bankInfoView.alpha = 0
        bankInfoView.textColor = hxb.color.light
        
        bankNoView.keyboardType = .numberPad
        
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
            maker.height.equalTo(hxb.size.inputHeight)
        }
        
        idcardView.snp.makeConstraints { maker in
            maker.top.equalTo(nameView.snp.bottom)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(hxb.size.inputHeight)
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
            maker.bottom.equalToSuperview()
            maker.height.equalTo(hxb.size.inputHeight)
        }
        
        bankInfoView.snp.makeConstraints { maker in
            maker.top.equalTo(bankNoView.snp.bottom)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(0)
        }
        
        bottomBtn.snp.makeConstraints { maker in
            maker.left.equalTo(35)
            maker.right.equalTo(-35)
            maker.height.equalTo(hxb.size.wideButtonHeight)
            maker.top.equalTo(self.bankInfoView.snp.bottom).offset(40)
        }
    }
    
    fileprivate func setBindings() {
        bankInfoShowSignal = bankNoView.fieldEventSignal.map { $0.replacingOccurrences(of: " ", with: "").count >= hxb.size.bankNoMinCount }
        
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
    @objc fileprivate func bankList() {
        HXBNavigationController(rootViewController: HXBBankListController()).presentFrom(controller: self, animated: true)
    }
    
    @objc fileprivate func createDepositoryAccount() {
        guard checkInputsValidate() else {
            return
        }
        
        var param = [String: String]()
        param["realName"] = nameView.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        param["identityCard"] = idcardView.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        param["bankCard"] = bankNoView.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        param["bankCode"] = viewModel.bankCode ?? ""
        
        viewModel.openDepository(param: param) { isSuccess in
            
        }
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
        if (nameView.text ?? "").isEmpty {
            HXBHUD.show(toast: "真实姓名不能为空", in: view)
            return false
        }
        
        guard checkInput(inputView: idcardView, toastEmpty: "身份证号不能为空", toastCount: "身份证号输入有误", limitCount: 18, toastView: view),
            checkInput(inputView: bankNoView, toastEmpty: "银行卡号不能为空", toastCount: "银行卡号输入有误", min: 10, max: 31, toastView: view) else {
            return false
        }
        return true
    }
    
    fileprivate func checkBankNo(_ bankNo: String) {
        viewModel.checkBankNo(bankNo)
    }
    
    fileprivate func viewTitle(_ title: String, description: String) -> UIView {
        let titleLabel = UILabel(text: "●  \(title)  ●", font: hxb.font.mainContent, textColor: UIColor(stringHexValue: "0x003d7e")!, textAlignment: .center)
        let descLabel = UILabel(text: description, font: hxb.font.light, textColor: hxb.color.light, textAlignment: .center)
        
        let view = UIView()
        
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(40)
            maker.centerX.left.right.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(-20)
            maker.centerX.left.right.equalToSuperview()
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
        let height = needShow ? hxb.size.inputHeight : 0
        bankInfoView.snp.updateConstraints({ maker in
            maker.height.equalTo(height)
        })
        
//        bankNoView.hideBottomLine = !needShow
        bankInfoView.leftImage = UIImage(bank.bankCode) ?? UIImage("default_bank")
        bankInfoView.leftViewSize = CGSize(width: 15, height: 15)
        bankInfoView.text = update ? bank.bankType + bank.quota : bank.bankName + "：" + bank.quota
        if update {
            bankNoView.text = bank.cardId
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
            self.bankInfoView.alpha = needShow ? 1 : 0
        })
    }
}

// MARK: - Other
extension HXBDepositoryOpenOrModifyController {
}
