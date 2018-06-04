//
//  HXBAccountMainController.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

/// 账户信息页面
class HXBAccountMainController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "账户信息"
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        HXBAccountViewModel.shared.updateUserInfo()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var tableView = HXBTableView(dataSource: nil, delegate: nil)
    fileprivate let viewModel = HXBAccountMainViewModel()
}

// MARK: - UI
extension HXBAccountMainController {
    fileprivate func setUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HXBAccountMainCell.self, forCellReuseIdentifier: HXBAccountMainCell.identifier)
        tableView.rowHeight = HXBMineCell.cellHeight
        tableView.sectionHeaderHeight = hxb.size.view2View
        tableView.tableFooterView = UIButton(title: "退出当前账号", font: hxb.font.transaction, titleColor: hxb.color.mostImport, target: self, action: #selector(signOut))
        tableView.tableFooterView?.frame.size.height = HXBAccountMainCell.cellHeight
        tableView.tableFooterView?.backgroundColor = hxb.color.white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(view.safeAreaInsets.top)
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(view.safeAreaInsets.bottom)
        }
    }
}

// MARK: - Action
extension HXBAccountMainController {
    @objc fileprivate func signOut() {
        let alertVC = HXBAlertController(title: "提示", messageText: "您确定要退出登录吗？", leftActionName: "取消", rightActionName: "确定")
        alertVC.rightAction = { [weak self] in
            self?.viewModel.signOut(completion: { isSuccess in
                if isSuccess {
                    self?.navigationController?.popToRootViewController(animated: false)
                    HXBRootVCManager.shared.tabBarController?.selectedIndex = 0
                }
            })
        }
        alertVC.presentFrom(controller: self, animated: true)
    }
}

// MARK: - Network
extension HXBAccountMainController {
    
}

// MARK: - Delegate Internal

// MARK: - UITableViewDataSource
extension HXBAccountMainController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HXBAccountMainCell.identifier, for: indexPath) as! HXBAccountMainCell
        cell.viewModel = viewModel.dataSource[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == viewModel.dataSource.count - 1 ? hxb.size.view2View : 0.001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.dataSource[indexPath.section][indexPath.row]
        
        switch cellViewModel.type {
        case .depositoryAccount:
            clickDepositoryAccount()
        case .bank:
            clickBank()
        case .risk:
            clickRisk()
        case .accountSecure:
            clickAccountSecure()
        case .advisor:
            clickAdvisor()
        case .about:
            clickAbout()
        case .username:
            break
        }
    }
}

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBAccountMainController {
    fileprivate func clickDepositoryAccount() {
        if HXBAccountViewModel.shared.isIdUnBinding {
            HXBAlertController.phoneCall(title: "温馨提示", message: "您的身份信息不完善，请联系客服 \(hxb.string.servicePhone)")
            return
        }
        if !HXBAccountViewModel.shared.hasDepositoryOpen {
            let checkVC = HXBDepositoryCheckViewController()
            checkVC.presentFrom(controller: self, animated: false).openClosure = { [weak checkVC] in
                checkVC?.dismiss(animated: false, completion: nil)
                HXBDepositoryOpenOrModifyController().pushFrom(controller: self, animated: true)
            }
        } else if HXBAccountViewModel.shared.hasBindCard {
            if HXBAccountViewModel.shared.hasTransitionPwd == false {
                HXBDepositoryOpenOrModifyController().pushFrom(controller: self, animated: true)
            }
        } else if HXBAccountViewModel.shared.hasTransitionPwd {
            
        } else {
            
        }
    }
    
    fileprivate func clickBank() {
        
    }
    
    fileprivate func clickRisk() {
        
    }
    
    fileprivate func clickAccountSecure() {
        
    }
    
    fileprivate func clickAdvisor() {
        
    }
    
    fileprivate func clickAbout() {
        
    }
    
    
}

// MARK: - Other
extension HXBAccountMainController {
    
}

// MARK: - Public
extension HXBAccountMainController {
    
}

