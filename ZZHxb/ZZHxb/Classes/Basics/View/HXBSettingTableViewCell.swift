//
//  HXBSettingTableViewCell.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import SnapKit

class HXBSettingTableViewCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    
    /// 隐藏右边图标
    var hideRightIcon = false {
        didSet {
            rightIconView.isHidden = hideRightIcon
        }
    }
    
    /// 左边标题 右边的View，需要自己设置约束
    let leftAccessoryView = UIView()
    /// 右边图标 左边的View，需要自己设置约束
    let rightAccessoryView = UIView()
    /// 左边标题
    let leftLabel = UILabel()
    /// 右边图标
    let rightIconView = UIImageView()
    /// 底部线
    let bottomLine = UIView()
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension HXBSettingTableViewCell {
    fileprivate func setUI() {
        contentView.addSubview(leftLabel)
        contentView.addSubview(leftAccessoryView)
        contentView.addSubview(rightIconView)
        contentView.addSubview(rightAccessoryView)
        contentView.addSubview(bottomLine)
        
        bottomLine.backgroundColor = hxb.color.sepLine
        
        leftLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(hxb.size.edgeScreen)
            maker.centerY.equalToSuperview()
        }
        
        rightIconView.snp.makeConstraints { (maker) in
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.centerY.equalToSuperview()
            maker.size.equalTo(CGSize(width: 8, height: 15))
        }
        
        bottomLine.snp.makeConstraints { (maker) in
            maker.bottom.left.right.equalToSuperview()
            maker.height.equalTo(hxb.size.sepLineHeight)
        }
        
    }
}
