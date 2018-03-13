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
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 309 + hxb.size.topAddtionHeight))
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    var iconClick: (() -> ())?
    var bgViewClick: (() -> ())?
    var chargeClick:(() -> ())?
    var withDrawClick:(() -> ())?
    
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

// MARK: - UI
extension HXBMineHeaderView {
    fileprivate func setUI() {
        backgroundColor = hxb.color.white
        
        addSubview(backgroundView)
        backgroundView.addSubview(iconView)
        backgroundView.addSubview(holdMoneyTitleLabel)
        backgroundView.addSubview(holdMoneyLabel)
        backgroundView.addSubview(availableMoneyTitleLabel)
        backgroundView.addSubview(availableMoneyLabel)
        backgroundView.addSubview(accumulatedMoneyTitleLabel)
        backgroundView.addSubview(accumulatedMoneyLabel)
        backgroundView.addSubview(eyeBtn)
        
        let bottomBgView = UIImageView(image: UIImage("mine_top_bottom"))
        bottomBgView.isUserInteractionEnabled = true
        addSubview(bottomBgView)
        
        let chargeBtn = UIButton(title: "充值", font: hxb.font.mainContent, titleColor: hxb.color.mostImport, imageName: "mine_charge", target:self, action: #selector(toCharge))
        let withDrawBtn = UIButton(title: "提现", font: hxb.font.mainContent, titleColor: hxb.color.mostImport, imageName: "mine_withdraw", target: self, action: #selector(toWithDraw))
        chargeBtn.imageEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        chargeBtn.imageView?.contentMode = .scaleAspectFit
        
        withDrawBtn.imageEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
        withDrawBtn.imageView?.contentMode = .scaleAspectFit
        
        bottomBgView.addSubview(chargeBtn)
        bottomBgView.addSubview(withDrawBtn)
        
        let sepLine = UIView()
        sepLine.backgroundColor = hxb.color.mostImport
        
        bottomBgView.addSubview(sepLine)
        
        iconView.isUserInteractionEnabled = true
        iconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iconTap)))
        
        eyeBtn.imageView?.contentMode = .scaleAspectFit
        eyeBtn.setImage(UIImage("mine_eyes"), for: .normal)
        eyeBtn.setImage(UIImage("mine_eyes_colsed"), for: .selected)
        
        eyeBtn.reactive.controlEvents(.touchUpInside).observeValues { btn in
            btn.isSelected = !btn.isSelected
        }
        
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bgViewTap)))
        
        backgroundView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(self.zz_height - hxb.size.commonRowHeight)
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
        
        bottomBgView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(adaptDecimal(340))
            maker.height.equalTo(hxb.size.commonRowHeight * 2 - 3)
            maker.bottom.equalToSuperview()
        }

        chargeBtn.snp.makeConstraints { maker in
            maker.right.equalTo(sepLine)
            maker.centerY.equalTo(sepLine).offset(-3)
            maker.width.equalTo(150)
            maker.height.equalTo(hxb.size.commonRowHeight)
        }

        withDrawBtn.snp.makeConstraints { maker in
            maker.left.equalTo(sepLine)
            maker.centerY.equalTo(chargeBtn)
            maker.size.equalTo(chargeBtn)
        }

        sepLine.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.height.equalTo(hxb.size.commonRowHeight * 0.5)
            maker.width.equalTo(hxb.size.sepLineWidth)
        }
    }
}

// MARK: - Action
extension HXBMineHeaderView {
    @objc fileprivate func iconTap() {
        iconClick?()
    }
    
    @objc fileprivate func bgViewTap() {
        bgViewClick?()
    }
    
    @objc fileprivate func toCharge() {
        chargeClick?()
    }
    
    @objc fileprivate func toWithDraw() {
        withDrawClick?()
    }
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
