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
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.zz_width, height: 111))
        
        let waveView1 = HXBSingleWaveView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 120))
        waveView1.alpha = 0.65
        
        let waveView2 = HXBSingleWaveView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 105))
        waveView2.alpha = 0.75
        
        let waveView3 = HXBSingleWaveView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 90))
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
