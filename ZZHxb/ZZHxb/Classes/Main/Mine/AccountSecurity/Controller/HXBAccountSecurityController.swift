//
//  HXBAccountSecurityController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/29.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountSecurityController: HXBViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "账户安全"
        setUI()
        HXBAccountViewModel.shared.updateUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.prepareData()
    }
    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var tableView = HXBTableView(style: .plain, dataSource: nil, delegate: nil)
    fileprivate let viewModel = HXBAccountSecurityViewModel()
}

// MARK: - UI
extension HXBAccountSecurityController {
    fileprivate func setUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HXBAccountSecurityCell.self, forCellReuseIdentifier: HXBAccountSecurityCell.identifier)
        tableView.rowHeight = HXBAccountSecurityCell.cellHeight
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

// MARK: - Delegate Internal

// MARK: -
extension HXBAccountSecurityController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HXBAccountSecurityCell.identifier, for: indexPath) as! HXBAccountSecurityCell
        cell.model = viewModel.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.dataSource[indexPath.row]
        switch model.type {
        case .phone: modifyPhone()
        case .SignInPwd: modifySignInPwd()
        case .transactionPwd: modifyTransactionPwd()
        case .gesturePwdSwitch: modifyGesturePwdSwitch()
        case .modifyGesturePwd: modifyGesturePwd()
        }
    }
}

// MARK: - Helper
extension HXBAccountSecurityController {
    fileprivate func modifyPhone() {
        if HXBAccountViewModel.shared.hasDepositoryOpen {
            if HXBAccountViewModel.shared.hasBindCard {
                HXBMobileUnbindingController().pushFrom(controller: self, animated: true)
            } else {
                let alertVC = HXBAlertController(title: "温馨提示", messageText: "由于银行限制，您需要绑定银行卡后方可修改手机号", leftActionName: "暂不绑定", rightActionName: "立即绑定")
                alertVC.rightAction = {
                    HXBBankBindingController(nextTo: .simpleBack).pushFrom(controller: self, animated: true)
                }
                alertVC.presentFrom(controller: self, animated: true, isAsyncMain: true)
            }
            
        } else {
            HXBMobileUnbindingController().pushFrom(controller: self, animated: true)
        }
    }
    
    fileprivate func modifySignInPwd() {
        HXBSignInPwdModifyController().pushFrom(controller: self, animated: true)
    }
    
    fileprivate func modifyTransactionPwd() {
        if HXBAccountViewModel.shared.hasDepositoryOpen {
            HXBTransactionPwdModifyController().pushFrom(controller: self, animated: true)
        } else {
            let checkVC = HXBDepositoryCheckViewController()
            checkVC.presentFrom(controller: self, animated: false, isAsyncMain: true).openClosure = { [weak checkVC] in
                checkVC?.dismiss(animated: false, completion: nil)
                HXBDepositoryOpenOrModifyController().pushFrom(controller: self, animated: true)
            }
        }
    }
    
    fileprivate func modifyGesturePwdSwitch() {
        /// 什么都不做，由开关触发要处理的事情
    }
    
    fileprivate func modifyGesturePwd() {
        
    }
}

// MARK: - Other
extension HXBAccountSecurityController {
    
}


