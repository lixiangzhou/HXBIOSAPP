//
//  HXBMineCell.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBMineCell: HXBSettingTableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        addObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder :) has not been implemented")
    }
    
    deinit {
        
    }
    
    // MARK: - Public Property
    static let identifier = "HXBMineCellIdentifier"
    static let cellHeight: CGFloat = 44
    
    var model: HXBMineCellModel? {
        didSet {
            leftLabel.text = model?.title
        }
    }
    
    // MARK: - Private Property
    
}

// MARK: - Observers
extension HXBMineCell {
    fileprivate func addObservers() {
        
    }
}

// MARK: - UI
extension HXBMineCell {
    fileprivate func setUI() {
        leftLabel.textColor = hxb.color.normal
        leftLabel.font = hxb.font.mainContent
        rightIconView.image = UIImage(named: "settingcell_arrow")
    }
}

// MARK: - Action
extension HXBMineCell {
    
}

// MARK: - Helper
extension HXBMineCell {
    
}

// MARK: - Other
extension HXBMineCell {
    
}

// MARK: - Public
extension HXBMineCell {

}
