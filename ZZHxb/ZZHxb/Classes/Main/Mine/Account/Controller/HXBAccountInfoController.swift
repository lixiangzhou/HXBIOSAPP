//
//  HXBAccountInfoController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/26.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountInfoController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "开户信息"
        viewModel = HXBAccountInfoViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var tableView: HXBTableView!
    fileprivate var viewModel: HXBAccountInfoViewModel!
}

// MARK: - UI
extension HXBAccountInfoController {
    fileprivate func setUI() {
        view.backgroundColor = hxb.color.background
        let tipLabel = UILabel(text: "您在红小宝已成功开通恒丰银行存管账户", font: hxb.font.transaction, textColor: hxb.color.light, numOfLines: 1, textAlignment: .center)
        tipLabel.frame = CGRect(origin: .zero, size: CGSize(width: 0, height: 45))
        
        tableView = HXBTableView(dataSource: self, delegate: nil)
        tableView.rowHeight = HXBAccountInfoCell.cellHeight
        tableView.register(HXBAccountInfoCell.self, forCellReuseIdentifier: HXBAccountInfoCell.identifier)
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        
        tableView.tableHeaderView = tipLabel
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

// MARK: - Delegate Internal

// MARK: -
extension HXBAccountInfoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HXBAccountInfoCell.identifier, for: indexPath) as! HXBAccountInfoCell
        cell.info = viewModel.dataSource[indexPath.row]
        return cell
    }
    
}


