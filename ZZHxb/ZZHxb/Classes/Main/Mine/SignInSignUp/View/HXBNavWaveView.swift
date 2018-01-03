 //
//  HXBNavWaveView.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/20.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

 class HXBNavWaveView: UIView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        let maxHeight: CGFloat = 25
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: hxb.size.navigationHeight + HXBSingleWaveView.waveHeight + maxHeight))
        
        let waveView1 = HXBSingleWaveView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: zz_height))
        waveView1.alpha = 0.65
        
        let waveView2 = HXBSingleWaveView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: zz_height - 15))
        waveView2.alpha = 0.75
        
        let waveView3 = HXBSingleWaveView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: zz_height - 25))
        waveView3.alpha = 0.85
        
        addSubview(waveView1)
        addSubview(waveView2)
        addSubview(waveView3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public
extension HXBNavWaveView {
    
}
