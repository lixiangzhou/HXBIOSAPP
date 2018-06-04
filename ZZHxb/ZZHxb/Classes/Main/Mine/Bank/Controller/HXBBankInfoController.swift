//
//  HXBBankInfoController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/26.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBBankInfoController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "银行卡信息"
        viewModel = HXBBankInfoViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
        setBindings()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var viewModel: HXBBankInfoViewModel!
    
    fileprivate let bankView = UIView()
    fileprivate let phoneLabel = ActiveLabel(text: "如有问题，请联系红小宝客服：\(hxb.string.servicePhone)", font: hxb.font.light, textColor: hxb.color.important, numOfLines: 0)
    fileprivate let bankIconView = UIImageView()
    fileprivate let bankNameLabel = UILabel(text: "", font: hxb.font.mainContent, textColor: UIColor(stringHexValue: "555555")!)
    fileprivate let realNameLabel = UILabel(text: "", font: hxb.font.light, textColor: UIColor(stringHexValue: "555555")!)
    fileprivate let bankNumLabel = UILabel(text: "", font: hxb.font.important, textColor: hxb.color.mostImport)
    fileprivate let bankTipLabel = UILabel(text: "", font: hxb.font.light, textColor: hxb.color.light)
}

// MARK: - UI
extension HXBBankInfoController {
    fileprivate func setUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIButton(title: "解绑", font: hxb.font.transaction, titleColor: hxb.color.white, target: self, action: #selector(unbinding)))
        
        addBankView()
        addService()
    }
    
    fileprivate func setBindings() {
        viewModel.bankInfoSignal.observeValues { [weak self] bankModel in
            self?.bankIconView.image = UIImage(bankModel.bankCode) ?? UIImage("default_bank")
            self?.bankNameLabel.text = bankModel.bankType
            
            self?.realNameLabel.text = "持卡人：\(bankModel.name.zz_replace(start: 0, length: bankModel.name.count - 1, with: "*"))"
            self?.bankNumLabel.attributedText = self?.viewModel.formatBankNum(bankModel.cardId, limitWidth: self?.bankNumLabel.zz_size.width ?? 300)
            self?.bankTipLabel.text = bankModel.quota
        }
    }
    
    private func addBankView() {
        let tipLabel = UILabel(text: "您在红小宝平台充值，提现均会使用该卡", font: hxb.font.transaction, textColor: hxb.color.light, numOfLines: 1, textAlignment: .center)
        tipLabel.frame = CGRect(origin: .zero, size: CGSize(width: view.zz_width, height: 45))
        view.addSubview(tipLabel)
        
        view.addSubview(bankView)
        
        let bankBg = UIImageView(named: "mine_bank_bg")
        bankView.addSubview(bankBg)
        bankView.addSubview(bankIconView)
        bankView.addSubview(bankNameLabel)
        bankView.addSubview(realNameLabel)
        bankView.addSubview(bankNumLabel)
        bankView.addSubview(bankTipLabel)
        
        bankView.snp.makeConstraints { maker in
            maker.top.equalTo(tipLabel.snp.bottom)
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.height.equalTo(162)
        }
        
        bankBg.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        bankIconView.snp.makeConstraints { maker in
            maker.left.equalTo(30)
            maker.top.equalTo(20)
            maker.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        bankNameLabel.snp.makeConstraints { maker in
            maker.left.equalTo(bankIconView.snp.right).offset(15)
            maker.top.equalTo(bankIconView)
        }
        
        realNameLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(bankIconView)
            maker.left.equalTo(bankNameLabel)
        }
        
        bankNumLabel.snp.makeConstraints { maker in
            maker.left.equalTo(bankIconView)
            maker.right.equalTo(-30)
            maker.top.equalTo(bankIconView.snp.bottom).offset(20)
        }
        
        bankTipLabel.snp.makeConstraints { maker in
            maker.left.equalTo(bankIconView)
            maker.bottom.equalTo(-20)
        }
    }
    
    private func addService() {
        let customType = ActiveType.custom(pattern: "\(hxb.string.servicePhone)")
        phoneLabel.enabledTypes.append(customType)
        
        phoneLabel.customize { label in
            label.lineSpacing = 4
            label.customColor[customType] = hxb.color.linkActivity
            label.handleCustomTap(for: customType) { string in
                HXBAlertController.phoneCall(phone: string, title: "红小宝客服电话", message: string, left: "取消", right: "拨打", isAsyncMain: true)
            }
        }
        
        view.addSubview(phoneLabel)
        
        phoneLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(-30)
        }
    }
}

// MARK: - Action
extension HXBBankInfoController {
    @objc fileprivate func unbinding() {
        if viewModel.enableUnBind {
            HXBBankUnBindingController(bankModel: viewModel.bankModel).pushFrom(controller: self, animated: true)
        } else {
            if viewModel.enableUnBindReason.count > 0 {
                HXBHUD.show(toast: viewModel.enableUnBindReason, in: view)
            }
        }
    }
}

// MARK: - Helper
extension HXBBankInfoController {
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        phoneLabel.snp.updateConstraints { maker in
            maker.bottom.equalTo(-view.safeAreaInsets.bottom - 30)
        }
    }
}

