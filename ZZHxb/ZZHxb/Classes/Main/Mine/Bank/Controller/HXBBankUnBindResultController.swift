//
//  HXBBankUnBindResultController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/27.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBBankUnBindResultController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "解绑银行卡"
        setUI()
    }

    // MARK: - Public Property
    var isSuccess = true
    var bankLast4 = "0000"
    var descString = ""
    // MARK: - Private Property
    
}

// MARK: - UI
extension HXBBankUnBindResultController {
    fileprivate func setUI() {
        let imgView = UIImageView(named: isSuccess ? "result_successful" : "result_failure")
        imgView.contentMode = .scaleAspectFit
        view.addSubview(imgView)
        
        let titleLabel = UILabel(text: isSuccess ? "解绑成功" : "解绑失败", font: hxb.font.pageTitle, textColor: hxb.color.important, textAlignment: .center)
        view.addSubview(titleLabel)
        
        let desc = isSuccess ? "尾号\(bankLast4)的银行卡解绑成功" : descString
        let descLabel = UILabel(text: desc, font: hxb.font.mainContent, textColor: hxb.color.light, numOfLines: 0, textAlignment: .center)
        view.addSubview(descLabel)
        
        let actionBtn = UIButton(title: isSuccess ? "绑定新卡" : "重新解绑", font: hxb.font.firstClass, titleColor: hxb.color.white, backgroundColor: hxb.color.mostImport, target: self, action: #selector(actionClick))
        actionBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        actionBtn.layer.masksToBounds = true
        view.addSubview(actionBtn)
        
        let accountBtn = UIButton(title: "我的账户", font: hxb.font.firstClass, titleColor: hxb.color.mostImport, backgroundColor: hxb.color.white, target: self, action: #selector(accountClick))
        accountBtn.layer.cornerRadius = hxb.size.wideButtonCornerRadius
        accountBtn.layer.masksToBounds = true
        accountBtn.layer.borderColor = hxb.color.mostImport.cgColor
        accountBtn.layer.borderWidth = hxb.size.sepLineWidth
        view.addSubview(accountBtn)
        
        imgView.snp.makeConstraints { maker in
            maker.top.equalTo(75)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(147)
            maker.height.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(imgView.snp.bottom).offset(30)
            maker.centerX.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(10)
            maker.centerX.equalToSuperview()
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.right.equalTo(-hxb.size.edgeScreen)
        }
        
        actionBtn.snp.makeConstraints { maker in
            maker.top.equalTo(descLabel.snp.bottom).offset(50)
            maker.height.equalTo(hxb.size.wideButtonHeight)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
        }
        
        accountBtn.snp.makeConstraints { maker in
            maker.top.equalTo(actionBtn.snp.bottom).offset(20)
            maker.height.equalTo(hxb.size.wideButtonHeight)
            maker.left.equalTo(hxb.size.wideButtonEdgeScreen)
            maker.right.equalTo(-hxb.size.wideButtonEdgeScreen)
        }
    }
}

// MARK: - Action
extension HXBBankUnBindResultController {
    @objc fileprivate func actionClick() {
        if isSuccess {
            HXBBankBindingController(nextTo: .popToAccountMain).pushFrom(controller: self, animated: true)
        } else {
            popToViewController("HXBBankInfoController")
        }
    }
    
    @objc fileprivate func accountClick() {
        popToViewController("HXBAccountMainController")
    }
}
