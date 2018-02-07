//
//  HXBBankListController.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/6.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

/// 银行卡列表
class HXBBankListController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = HXBBankListViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
        getData()
    }

    // MARK: - Public Property
    
    var selectBank: ((HXBBankModel) -> Void)?
    
    // MARK: - Private Property
    fileprivate var viewModel: HXBBankListViewModel!
    
    fileprivate var tableView: HXBTableView!
}

// MARK: - UI
extension HXBBankListController {
    fileprivate func setUI() {
        title = "银行卡列表"
        navBgImage = UIImage("navigation_blue")!
        showBack = true
        
        tableView = HXBTableView(frame: CGRect.zero, style: .plain, dataSource: self, delegate: self)
        tableView.register(HXBBankCell.self, forCellReuseIdentifier: HXBBankCell.identifier)
        tableView.rowHeight = HXBBankCell.cellHeight
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

// MARK: - Action
extension HXBBankListController {
    override func back() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Network
extension HXBBankListController {
    fileprivate func getData() {
        viewModel.getBankList { [weak self] isSuccess in
            if isSuccess {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - Delegate Internal

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HXBBankListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HXBBankCell.identifier, for: indexPath) as! HXBBankCell
        cell.bank = viewModel.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectBank?(viewModel.dataSource[indexPath.row])
    }
}

