//
//  HXBAccountMainCell.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountMainCell: HXBSettingTableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    static let identifier = "HXBAccountMainCellIdentifier"
    static let cellHeight: CGFloat = 44
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension HXBAccountMainCell {
    fileprivate func setUI() {
        
    }
}

// MARK: - Action
extension HXBAccountMainCell {
    
}

// MARK: - Helper
extension HXBAccountMainCell {
    
}

// MARK: - Other
extension HXBAccountMainCell {
    
}

// MARK: - Public
extension HXBAccountMainCell {
    
}
