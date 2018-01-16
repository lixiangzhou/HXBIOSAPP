//
//  HXBAccountMainController.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountMainController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var tableView = HXBTableView(dataSource: nil, delegate: nil)
    fileprivate let viewModel = HXBAccountMainViewModel()
}

// MARK: - UI
extension HXBAccountMainController {
    fileprivate func setUI() {
        title = "账户信息"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HXBAccountMainCell.self, forCellReuseIdentifier: HXBAccountMainCell.identifier)
        tableView.rowHeight = HXBMineCell.cellHeight
        
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
    
}

// MARK: - Network
extension HXBAccountMainController {
    
}

// MARK: - Delegate Internal

// MARK: - UITableViewDataSource
extension HXBAccountMainController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HXBAccountMainCell.identifier, for: indexPath) as! HXBAccountMainCell
//        cell.model = viewModel.dataSource[indexPath.section][indexPath.row]
        return cell
    }
}

extension HXBAccountMainController: UITableViewDelegate {
    
}

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBAccountMainController {
    
}

// MARK: - Other
extension HXBAccountMainController {
    
}

// MARK: - Public
extension HXBAccountMainController {
    
}

