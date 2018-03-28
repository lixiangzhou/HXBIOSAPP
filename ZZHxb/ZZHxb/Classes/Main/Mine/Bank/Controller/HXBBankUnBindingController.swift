//
//  HXBBankUnBindingController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/27.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBBankUnBindingController: HXBViewController {

    // MARK: - Life Cycle
    convenience init(bankModel: HXBBankCardBinModel) {
        self.init(nibName: nil, bundle: nil)
        
        viewModel.bankModel = bankModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "解绑银行卡"
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate let viewModel = HXBBankUnBindingViewModel()
    
    fileprivate var bankInfoView: UIView!
    fileprivate let idCardView = HXBInputFieldView.commonFieldView(leftImage: UIImage("input_idcard_red"), placeholder: "请输入身份证号", leftSpacing: 5, rightSpacing: 5, bottomLineColor: hxb.color.sepLine)
    fileprivate var transactionPwdView: HXBInputFieldView!
    fileprivate var unBindBtn: UIButton!
}

// MARK: - UI
extension HXBBankUnBindingController {
    fileprivate func setUI() {
        view.backgroundColor = hxb.color.white
        
        addBankInfoView()
        
        addBottomView()
    }
    
    private func addBottomView() {
        let nameLabel = UILabel(text: "认证姓名：\(viewModel.userName)", font: hxb.font.mainContent, textColor: hxb.color.important)
        view.addSubview(nameLabel)
        
        idCardView.leftViewSize = CGSize(width: 24, height: 15)
        idCardView.inputLengthLimit = 18
        view.addSubview(idCardView)
        
        let transactionPwdLabel = UILabel(text: "交易密码", font: hxb.font.mainContent, textColor: hxb.color.important)
        view.addSubview(transactionPwdLabel)
        
        let forgetBtn =  UIButton(title: "忘记密码?", font: hxb.font.light, titleColor: hxb.color.linkActivity, target: self, action: #selector(forgetTransactionPwd))
        forgetBtn.sizeToFit()
        transactionPwdView = HXBInputFieldView.rightClickViewFieldView(leftImage: UIImage("input_password"), placeholder: "请输入交易密码", clickView: forgetBtn, leftSpacing: 5, rightSpacing: 5, bottomLineColor: hxb.color.sepLine)
        transactionPwdView.leftViewSize = CGSize(width: 24, height: 20)
        transactionPwdView.inputLengthLimit = 6
        view.addSubview(transactionPwdView)
        
        let tipIconView = UIImageView(named: "tip_blue")
        view.addSubview(tipIconView)
        
        let descLabel = UILabel(text: "您正在解绑尾号\(viewModel.bankNoLast4)的银行卡。解绑后需重新绑定方可进行充值提现操作。", font: hxb.font.mainContent, textColor: hxb.color.light)
        view.addSubview(descLabel)
        
        unBindBtn = UIButton(title: "确认解绑", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(unBind))
        unBindBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        unBindBtn.layer.masksToBounds = true
        view.addSubview(unBindBtn)
        
        nameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(bankInfoView.snp.bottom).offset(15)
            maker.left.equalTo(hxb.size.edgeScreen)
        }
        
        idCardView.snp.makeConstraints { maker in
            maker.top.equalTo(nameLabel.snp.bottom).offset(15)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(50)
        }
        
        transactionPwdLabel.snp.makeConstraints { maker in
            maker.top.equalTo(idCardView.snp.bottom).offset(30)
            maker.left.equalTo(nameLabel)
        }
        
        transactionPwdView.snp.makeConstraints { maker in
            maker.top.equalTo(transactionPwdLabel.snp.bottom).offset(15)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(50)
        }
        
        tipIconView.snp.makeConstraints { maker in
            maker.top.equalTo(transactionPwdView.snp.bottom).offset(30)
            maker.left.equalTo(nameLabel)
            maker.size.equalTo(CGSize(width: 13, height: 13))
        }
        
        descLabel.snp.makeConstraints { maker in
            maker.top.equalTo(tipIconView).offset(-2)
            maker.left.equalTo(tipIconView.snp.right).offset(5)
            maker.right.equalTo(-hxb.size.edgeScreen)
        }
        
        unBindBtn.snp.makeConstraints { maker in
            maker.height.equalTo(hxb.size.wideButtonHeight)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
            maker.bottom.equalTo(-70)
        }
    }
    
    private func addBankInfoView() {
        bankInfoView = UIView()
        view.addSubview(bankInfoView)
        
        let bankIconView = UIImageView()
        bankIconView.image = viewModel.bankImage
        bankInfoView.addSubview(bankIconView)
        
        let bankNameLabel = UILabel(text: viewModel.bankName, font: hxb.font.mainContent, textColor: hxb.color.important)
        bankInfoView.addSubview(bankNameLabel)
        
        let bankNoLabel = UILabel(text: viewModel.bankNo, font: hxb.font.light, textColor: hxb.color.light)
        bankInfoView.addSubview(bankNoLabel)
        
        bankInfoView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(90)
        }
        
        bankIconView.snp.makeConstraints { maker in
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.top.equalTo(20)
            maker.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        bankNameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(bankIconView)
            maker.left.equalTo(bankIconView.snp.right).offset(18)
        }
        
        bankNoLabel.snp.makeConstraints { maker in
            maker.left.equalTo(bankNameLabel)
            maker.bottom.equalTo(bankIconView)
        }
        
        let sepView = UIView()
        sepView.backgroundColor = hxb.color.background
        bankInfoView.addSubview(sepView)
        
        sepView.snp.makeConstraints { maker in
            maker.top.equalTo(bankIconView.snp.bottom).offset(20)
            maker.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension HXBBankUnBindingController {
    @objc fileprivate func forgetTransactionPwd() {
        HXBModifyTransactionPwdController().pushFrom(controller: self, animated: true)
    }
    
    @objc fileprivate func unBind() {
        let idCardNo = idCardView.text?.replacingOccurrences(of: " ", with: "") ?? ""
        let transactionPwd = transactionPwdView.text?.replacingOccurrences(of: " ", with: "") ?? ""
        
        guard viewModel.validate(idNo: idCardNo, pwd: transactionPwd) else {
            return
        }
        
        viewModel.unBind(param: ["idCardNo": idCardNo, "cashPassword": transactionPwd]) { isSuccess, canPush, message in
            if canPush {
                let VC = HXBBankUnBindResultController()
                VC.isSuccess = isSuccess
                VC.descString = message
                VC.bankLast4 = self.viewModel.bankNoLast4
                VC.pushFrom(controller: self, animated: true)
            }
        }
    }
}

// MARK: - Helper
extension HXBBankUnBindingController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let childVC = navigationController?.childViewControllers else {
            return
        }
        
        for vc in childVC {
            print(vc.classForCoder)
        }
    }
}

// MARK: - Other
extension HXBBankUnBindingController {
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        unBindBtn.snp.updateConstraints { maker in
            maker.bottom.equalTo(-70 - view.safeAreaInsets.bottom)
        }
    }
}

