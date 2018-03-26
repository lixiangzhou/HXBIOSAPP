//
//  HXBAccountInfoCell.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/26.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountInfoCell: HXBSettingTableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    static let identifier = "HXBAccountInfoCellIdentifier"
    static let cellHeight: CGFloat = 44
    
    var info: HXBAccountInfoModel? {
        didSet {
            leftLabel.text = info?.type
            rightLabel.text = info?.value
            
            let hasLink = info?.link != nil
            rightLabel.textColor = hasLink ? hxb.color.linkActivity : hxb.color.light
            
            rightLabel.gestureRecognizers?.removeAll()
            rightLabel.isUserInteractionEnabled = hasLink
            if hasLink {
                let tap = UITapGestureRecognizer(target: self, action: #selector(linkClick))
                rightLabel.addGestureRecognizer(tap)
            }
        }
    }
    
    // MARK: - Private Property
    fileprivate var rightLabel = UILabel(text: "", font: hxb.font.light, textColor: hxb.color.light, numOfLines: 1, textAlignment: .right)
}

// MARK: - UI
extension HXBAccountInfoCell {
    fileprivate func setUI() {
        leftLabel.font = hxb.font.mainContent
        leftLabel.textColor = hxb.color.important
        
        contentView.addSubview(rightLabel)
        
        rightLabel.snp.makeConstraints { maker in
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.top.bottom.equalToSuperview()
        }
        bottomLine.isHidden = true
    }
}

// MARK: - Action
extension HXBAccountInfoCell {
    @objc fileprivate func linkClick() {
        zz_controller?.navigationController?.pushViewController(HXBWebController(urlString: info!.link!), animated: true)
    }
}

