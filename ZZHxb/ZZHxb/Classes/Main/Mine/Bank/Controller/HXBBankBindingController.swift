//
//  HXBBankBindingController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/26.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

enum HXBBankBindingNextTo: String {
    case simpleBack = "简单返回"
    case popToAccountMain = "返回个人信息主页面"
}

class HXBBankBindingController: HXBViewController {
    
    convenience init(nextTo: HXBBankBindingNextTo) {
        self.init(nibName: nil, bundle: nil)
        
        self.nextTo = nextTo
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "绑卡"
        viewModel = HXBBankBindingViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
        setBindings()
    }

    // MARK: - Public Property
    var nextTo: HXBBankBindingNextTo!
    
    // MARK: - Private Property
    fileprivate var viewModel: HXBBankBindingViewModel!
    fileprivate var bankInfoShowSignal: Signal<Bool, NoError>!
    
    fileprivate var topView: UIView!
    fileprivate var nameLabel: UILabel!
    fileprivate var bankNoLabel: UILabel!
    
    fileprivate var bankNoView: HXBInputFieldView!
    fileprivate let bankInfoView = HXBInputFieldView.commonFieldView(leftImage: UIImage("default_bank"), placeholder: "", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
    
    fileprivate let phoneView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_phone"), placeholder: "银行预留手机号", leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: UIColor.clear)
}

// MARK: - UI
extension HXBBankBindingController {
    fileprivate func setUI() {
        view.backgroundColor = hxb.color.background
        
        setTopView()
        setBottomView()
    }
    
    private func setBottomView() {
        let bottomView = UIView()
        bottomView.backgroundColor = hxb.color.white
        view.addSubview(bottomView)
        
        let btn = UIButton(title: "查看银行限额", font: hxb.font.transaction, titleColor: hxb.color.linkActivity, target: self, action: #selector(bankList))
        btn.frame.size = btn.currentTitle!.zz_size(withLimitSize: CGSize(width: 1000, height: 1000), fontSize: 14)
        
        bankNoView = HXBInputFieldView.rightClickViewFieldView(leftImage: UIImage("input_bank_red"), placeholder: "银行卡号", clickView: btn, leftSpacing: hxb.size.edgeScreen, rightSpacing: hxb.size.edgeScreen, bottomLineColor: hxb.color.sepLine)
        bankNoView.inputLengthLimit = hxb.size.bankNoMaxCount
        bankNoView.keyboardType = .numberPad
        bankNoView.bankNoMode = true

        bankNoView.inputViewChangeClosure = { [weak self] textField in
            if let text = textField.text?.replacingOccurrences(of: " ", with: ""),
                text.count >= hxb.size.bankNoMinCount {
                self?.viewModel.checkBankNo(text)
            }
        }
        
        let sepView = UIView()
        sepView.backgroundColor = hxb.color.background
        
        bankInfoView.alpha = 0
        phoneView.keyboardType = .numberPad
        phoneView.inputLengthLimit = hxb.size.phoneLength
        
        bottomView.addSubview(bankNoView)
        bottomView.addSubview(bankInfoView)
        bottomView.addSubview(sepView)
        bottomView.addSubview(phoneView)
        
        let bindingBtn = UIButton(title: "绑卡", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(bindCard))
        bindingBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        bindingBtn.layer.masksToBounds = true
        view.addSubview(bindingBtn)
        
        bottomView.snp.makeConstraints { maker in
            maker.top.equalTo(topView.snp.bottom)
            maker.right.left.equalToSuperview()
        }
        
        bankNoView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(hxb.size.inputHeight)
        }
        
        bankInfoView.snp.makeConstraints { maker in
            maker.top.equalTo(bankNoView.snp.bottom)
            maker.right.left.equalToSuperview()
            maker.height.equalTo(0)
        }
        
        sepView.snp.makeConstraints { maker in
            maker.top.equalTo(bankInfoView.snp.bottom)
            maker.left.right.equalToSuperview()
            maker.height.equalTo(hxb.size.view2View)
        }
        
        phoneView.snp.makeConstraints { maker in
            maker.top.equalTo(sepView.snp.bottom)
            maker.right.left.bottom.equalToSuperview()
            maker.height.equalTo(hxb.size.inputHeight)
        }
        
        bindingBtn.snp.makeConstraints { maker in
            maker.top.equalTo(phoneView.snp.bottom).offset(60)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
    }
    
    private func setTopView() {
        topView = UIView()
        view.addSubview(topView)
        
        nameLabel = UILabel(text: "", font: hxb.font.transaction, textColor: hxb.color.light)
        bankNoLabel = UILabel(text: "", font: hxb.font.transaction, textColor: hxb.color.light)
        
        topView.addSubview(nameLabel)
        topView.addSubview(bankNoLabel)
        
        topView.snp.makeConstraints { maker in
            maker.top.centerX.equalToSuperview()
            maker.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { maker in
            maker.top.bottom.left.equalToSuperview()
        }
        
        bankNoLabel.snp.makeConstraints { maker in
            maker.top.bottom.right.equalToSuperview()
            maker.left.equalTo(nameLabel.snp.right).offset(50)
        }
    }
    
    fileprivate func setBindings() {
        nameLabel.reactive.text <~ viewModel.cardHolderSignal
        bankNoLabel.reactive.text <~ viewModel.bankNoSignal
        
        bankInfoShowSignal = bankNoView.fieldEventSignal.map { $0.replacingOccurrences(of: " ", with: "").count >= hxb.size.bankNoMinCount }
        
        viewModel.bankCardSignal.producer.combineLatest(with: bankInfoShowSignal).map { ($0, $1 && $0.bankName.count > 0 && $0.bankCode.count > 0 && $0.quota.count > 0) }.startWithValues {[weak self] (bank, needShow) in
            self?.updateBankViews(bank: bank, needShow: needShow, update: false)
        }
    }
}

// MARK: - Action
extension HXBBankBindingController {
    @objc fileprivate func bankList() {
        HXBNavigationController(rootViewController: HXBBankListController()).presentFrom(controller: self, animated: true)
    }
    
    @objc fileprivate func bindCard() {
        
        guard checkInput(inputView: bankNoView, toastEmpty: "银行卡号不能为空", toastCount: "银行卡号输入有误", min: 10, max: 31, toastView: view),
            checkInput(inputView: phoneView, toastEmpty: "预留手机号不能为空", toastCount: "预留手机号有误", limitCount: 11, toastView: view) else {
                return
        }
        let bankNo = bankNoView.text?.replacingOccurrences(of: " ", with: "") ?? ""
        let mobile = phoneView.text?.replacingOccurrences(of: " ", with: "") ?? ""
        
        viewModel.bindCard(bankNo: bankNo, mobile: mobile) { isSuccess in
            if isSuccess {
                switch self.nextTo {
                case .popToAccountMain:
                    self.back()
                case .simpleBack:
                    self.back()
                default:
                    break
                }
            }
        }
    }
}

// MARK: - Helper
extension HXBBankBindingController {
    ///   - update: 是否是更新，false: 仅设置数据；true：更新数据
    fileprivate func updateBankViews(bank: HXBBankCardBinModel, needShow: Bool, update: Bool) {
        let height = needShow ? hxb.size.inputHeight : 0
        bankInfoView.snp.updateConstraints({ maker in
            maker.height.equalTo(height)
        })
        
        bankNoView.hideBottomLine = !needShow
        bankInfoView.leftImage = UIImage(bank.bankCode) ?? UIImage("default_bank")
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
extension HXBBankBindingController {
    override func back() {
        if nextTo == .popToAccountMain {
            popToViewController("HXBAccountMainController")
        } else {
            super.back()
        }
    }
}


