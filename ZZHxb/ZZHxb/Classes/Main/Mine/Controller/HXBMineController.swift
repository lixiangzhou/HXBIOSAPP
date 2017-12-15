//
//  HXBMineController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBMineController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        addObservers()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
//    
//    deinit {
//        
//    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var tableView = HXBTableView(dataSource: nil, delegate: nil)
    fileprivate var viewModel = HXBMineViewModel()
}

// MARK: - Observers
extension HXBMineController {
    fileprivate func addObservers() {
        
    }
}

// MARK: - UI
extension HXBMineController {
    fileprivate func setUI() {
        hideNavigationBar = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HXBMineCell.self, forCellReuseIdentifier: HXBMineCell.identifier)
        tableView.rowHeight = HXBMineCell.cellHeight
        
        tableView.tableHeaderView = HXBMineHeaderView()

        view.addSubview(tableView)
        
        tableView.frame = view.frame
    }
}

// MARK: - Action
extension HXBMineController {
    
}

// MARK: - Network
extension HXBMineController {
    
}

// MARK: - Delegate Internal

// MARK: - UITableViewDataSource
extension HXBMineController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource[section].groupModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HXBMineCell.identifier, for: indexPath) as! HXBMineCell
        cell.model = viewModel.dataSource[indexPath.section].groupModels?[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HXBMineController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let groupModel = viewModel.dataSource[section]
        if groupModel.showGroupName {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width - hxb.size.edgeScreen, height: groupModel.groupHeight))
            view.backgroundColor = hxb.color.white
            let label = UILabel(text: groupModel.groupName, font: hxb.font.mainContent, textColor: hxb.color.important)
            label.frame = CGRect(x: hxb.size.edgeScreen, y: 0, width: UIScreen.zz_width - hxb.size.edgeScreen, height: groupModel.groupHeight)
            view.addSubview(label)
            
            let bottomLine = UIView.sepLine()
            bottomLine.frame = CGRect(x: 0, y: view.zz_height - hxb.size.sepLineHeight, width: view.zz_width, height: hxb.size.sepLineHeight)
            bottomLine.backgroundColor = hxb.color.background
            view.addSubview(bottomLine)
            
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let groupModel = viewModel.dataSource[section]
        return groupModel.groupHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sep = UIView.sepLine()
        sep.backgroundColor = hxb.color.background
        return sep
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return hxb.size.view2View
    }
}

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBMineController {
    
}

// MARK: - Other
extension HXBMineController {
    
}

// MARK: - Public
extension HXBMineController {
    
}

