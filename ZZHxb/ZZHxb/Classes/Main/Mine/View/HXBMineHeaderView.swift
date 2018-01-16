//
//  HXBMineHeaderView.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
 
class HXBMineHeaderView: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 265 + hxb.size.topAddtionHeight))
        
        setUI()
        addObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    

    // MARK: - Public Property
    var viewModel: HXBMineViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            let eyeSignal = eyeBtn.reactive.controlEvents(.touchUpInside)
            
            holdMoneyLabel.reactive.text <~ viewModel.holdingTotalAssetsProducer.combineLatest(with: eyeSignal).map { $1.isSelected ? hxb.string.moneySecure : $0 }
            availableMoneyLabel.reactive.text <~ viewModel.availablePointProducer.combineLatest(with: eyeSignal).map { $1.isSelected ? hxb.string.moneySecure : $0 }
            accumulatedMoneyLabel.reactive.text <~ viewModel.holdingTotalAssetsProducer.combineLatest(with: eyeSignal).map { $1.isSelected ? hxb.string.moneySecure : $0 }
        }
    }
    
    // MARK: - Private Property
    fileprivate var backgroundView = UIImageView(image:
        UIImage.zz_gradientImage(
            fromColor: hxb.color.importantFill(hex: "fe654d"),
            toColor: hxb.color.importantFill(hex: "ff3d4f"),
            size: CGSize(width: UIScreen.zz_width, height: 1)))
    
    fileprivate var iconView = UIImageView(image: UIImage(named: "mine_account_center")!)
    
    fileprivate var holdMoneyTitleLabel = UILabel(text: "持有资产(元)", font: hxb.font.light, textColor: UIColor(white: 1, alpha: 0.6))
    fileprivate var holdMoneyLabel = UILabel(text: "0.00", font: hxb.font.mostImportant, textColor: hxb.color.white)
    
    fileprivate var availableMoneyTitleLabel = UILabel(text: "可用金额(元)", font: hxb.font.light, textColor: UIColor(white: 1, alpha: 0.6))
    fileprivate var availableMoneyLabel = UILabel(text: "0.00", font: hxb.font.firstClass, textColor: hxb.color.white)
    
    fileprivate var accumulatedMoneyTitleLabel = UILabel(text: "累计收益(元)", font: hxb.font.light, textColor: UIColor(white: 1, alpha: 0.6))
    fileprivate var accumulatedMoneyLabel = UILabel(text: "0.00", font: hxb.font.firstClass, textColor: hxb.color.white)
    fileprivate var eyeBtn = UIButton()//(image: UIImage("mine_eyes"), highlightedImage: UIImage("mine_eyes_colsed"))
    
}

// MARK: - Observers
extension HXBMineHeaderView {
    fileprivate func addObservers() {
        
    }
}

// MARK: - UI
extension HXBMineHeaderView {
    fileprivate func setUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(iconView)
        backgroundView.addSubview(holdMoneyTitleLabel)
        backgroundView.addSubview(holdMoneyLabel)
        backgroundView.addSubview(availableMoneyTitleLabel)
        backgroundView.addSubview(availableMoneyLabel)
        backgroundView.addSubview(accumulatedMoneyTitleLabel)
        backgroundView.addSubview(accumulatedMoneyLabel)
        backgroundView.addSubview(eyeBtn)
        
        eyeBtn.imageView?.contentMode = .scaleAspectFit
        eyeBtn.setImage(UIImage("mine_eyes"), for: .normal)
        eyeBtn.setImage(UIImage("mine_eyes_colsed"), for: .selected)
        
        eyeBtn.reactive.controlEvents(.touchUpInside).observeValues { btn in
            btn.isSelected = !btn.isSelected
        }
        
        backgroundView.isUserInteractionEnabled = true
        
        backgroundView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(self.zz_height)
        }
        
        iconView.snp.makeConstraints { (maker) in
            maker.top.equalTo(35 + hxb.size.topAddtionHeight)
            maker.left.equalTo(hxb.size.edgeScreen)
        }
        
        holdMoneyTitleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(iconView.snp.bottom).offset(18)
            maker.left.equalTo(iconView)
        }
        
        holdMoneyLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(iconView)
            maker.centerY.equalToSuperview()
        }
        
        eyeBtn.snp.makeConstraints { (maker) in
            maker.right.equalTo(-hxb.size.edgeScreen)
            maker.centerY.equalTo(holdMoneyLabel)
            maker.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        availableMoneyTitleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(iconView)
            maker.top.equalTo(holdMoneyLabel.snp.bottom).offset(32)
        }
        
        availableMoneyLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(iconView)
            maker.top.equalTo(availableMoneyTitleLabel.snp.bottom).offset(7)
        }
        
        accumulatedMoneyTitleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.centerX).offset(-15)
            maker.centerY.equalTo(availableMoneyTitleLabel)
        }
        
        accumulatedMoneyLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(accumulatedMoneyTitleLabel)
            maker.centerY.equalTo(availableMoneyLabel)
        }
        
    }
}

// MARK: - Action
extension HXBMineHeaderView {
    
}

// MARK: - Helper
extension HXBMineHeaderView {
    
}

// MARK: - Other
extension HXBMineHeaderView {
    
}

// MARK: - Public
extension HXBMineHeaderView {
    
}
