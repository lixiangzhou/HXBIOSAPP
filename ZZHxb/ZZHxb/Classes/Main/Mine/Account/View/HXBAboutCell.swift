//
//  HXBAboutCell.swift
//  ZZHxb
//
//  Created by lixiangzhou on 2018/6/8.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAboutCell: HXBSettingTableViewCell, HXBReactiveViewBinder {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    static let identifier = "HXBAboutCell"
    static let cellHeight: CGFloat = 45
    
    // MARK: - Private Property
    fileprivate let rightLabel = UILabel()
    fileprivate let leftAccessoryLabel = UILabel(font: hxb.font.light, textColor: hxb.color.light)
}

// MARK: - UI
extension HXBAboutCell {
    fileprivate func setUI() {
        rightIconView.image = UIImage("settingcell_arrow")
        leftLabel.textColor = hxb.color.important
        leftLabel.font = hxb.font.mainContent
        
        contentView.addSubview(leftAccessoryLabel)
        
        rightLabel.font = hxb.font.mainContent
        rightLabel.textColor = hxb.color.normal
        contentView.addSubview(rightLabel)
        
        leftAccessoryLabel.snp.makeConstraints { maker in
            maker.left.equalTo(leftLabel.snp.right).offset(hxb.size.view2View)
            maker.centerY.equalTo(contentView)
        }
        
        rightLabel.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
            maker.right.equalTo(rightIconView)
        }
    }
    
    func reactive_bind(_ vm: HXBAboutCellViewModel) {
        leftLabel.text = vm.title
        leftAccessoryLabel.text = vm.titleAccessoryString
        rightLabel.text = vm.accessoryTitle
        
        rightIconView.isHidden = vm.accessoryTitle != nil
    }
}
