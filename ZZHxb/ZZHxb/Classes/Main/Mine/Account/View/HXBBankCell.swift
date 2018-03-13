//
//  HXBBankCell.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/6.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBBankCell: UITableViewCell {
    
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
    static let identifier = "HXBBankCellIdentifier"
    static let cellHeight: CGFloat = 70
    
    var bank: HXBBankModel? {
        didSet {
//            iconView.image
            titleLabel.text = bank?.name
            subTitleLabel.text = bank?.quota
            iconView.image = UIImage(bank?.bankCode ?? "") ?? UIImage("default_bank")
        }
    }
    
    // MARK: - Private Property
    fileprivate let iconView = UIImageView()
    fileprivate let titleLabel = UILabel(font: hxb.font.mainContent, textColor: hxb.color.normal)
    fileprivate let subTitleLabel = UILabel(font: hxb.font.light, textColor: hxb.color.light)
}

// MARK: - UI
extension HXBBankCell {
    fileprivate func setUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        let lineView = UIView()
        lineView.backgroundColor = hxb.color.sepLine
        contentView.addSubview(lineView)
        
        iconView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(40)
            maker.left.equalTo(hxb.size.edgeScreen)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(iconView)
            maker.left.equalTo(iconView.snp.right).offset(hxb.size.edgeScreen)
        }
        
        subTitleLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(iconView)
            maker.left.equalTo(titleLabel)
        }
        
        lineView.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(hxb.size.sepLineWidth)
        }
    }
}
