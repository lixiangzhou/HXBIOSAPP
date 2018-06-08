//
//  HXBAboutController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/29.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAboutController: HXBViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "关于我们"
        viewModel = HXBAboutViewModel(progressContainerView: view, toastContainerView: view)
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate var tableView = HXBTableView(dataSource: nil, delegate: nil)
    fileprivate var viewModel: HXBAboutViewModel!
}

// MARK: - UI
extension HXBAboutController {
    fileprivate func setUI() {
        navBgImage = UIImage.zz_image(withColor: UIColor.clear, imageSize: 1)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HXBAboutCell.self, forCellReuseIdentifier: HXBAboutCell.identifier)
        tableView.rowHeight = HXBAboutCell.cellHeight
        tableView.sectionHeaderHeight = hxb.size.view2View
        tableView.backgroundColor = hxb.color.background
        tableView.tableHeaderView = getHeaderView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(view.safeAreaInsets.top)
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(view.safeAreaInsets.bottom)
        }
    }
}

// MARK: - Delegate Internal

// MARK: -
extension HXBAboutController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HXBAboutCell.identifier, for: indexPath) as! HXBAboutCell
        cell.reactive_bind(viewModel.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = hxb.color.background
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = viewModel.dataSource[indexPath.row]
        vm.action?(self)
    }
}

// MARK: - Helper
extension HXBAboutController {
    
}

// MARK: - Other
extension HXBAboutController {
    fileprivate func getHeaderView() -> UIImageView {
        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 300 + hxb.size.topAddtionHeight))
        headerView.image = UIImage("about_background")
        let logoView = UIImageView(named: "about_logo")
        headerView.addSubview(logoView)
        logoView.snp.makeConstraints { maker in
            maker.top.equalTo(110 + hxb.size.topAddtionHeight)
            maker.centerX.equalToSuperview()
            maker.size.equalTo(CGSize(width: 130, height: 130))
        }
        return headerView
    }
}

