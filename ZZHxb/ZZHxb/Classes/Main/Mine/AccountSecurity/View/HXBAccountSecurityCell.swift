//
//  HXBAccountSecurityCell.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/29.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountSecurityCell: HXBSettingTableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    static let identifier = "HXBAccountSecurityCellIdentifier"
    static let cellHeight: CGFloat = 44
    
    var model: HXBAccountSecurityModel? {
        didSet {
            leftLabel.text = model?.title
            let showSwitch = model?.type == .gesturePwdSwitch
            switchView.isHidden = !showSwitch
            rightIconView.isHidden = showSwitch
        }
    }
    
    // MARK: - Private Property
    fileprivate let switchView = UISwitch()
}

// MARK: - UI
extension HXBAccountSecurityCell {
    fileprivate func setUI() {
        rightIconView.image = UIImage("settingcell_arrow")
        
        leftLabel.textColor = hxb.color.important
        leftLabel.font = hxb.font.mainContent
        
        switchView.reactive.controlEvents(.valueChanged).observeValues { [weak self] switchView in
            self?.model?.switchClosure?(switchView.isOn)
        }
        
        contentView.addSubview(switchView)
        
        switchView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalTo(rightIconView)
        }
    }
}

// MARK: - Action
extension HXBAccountSecurityCell {
    
}

// MARK: - Helper
extension HXBAccountSecurityCell {
    
}

// MARK: - Other
extension HXBAccountSecurityCell {
    
}

// MARK: - Public
extension HXBAccountSecurityCell {
    
}
