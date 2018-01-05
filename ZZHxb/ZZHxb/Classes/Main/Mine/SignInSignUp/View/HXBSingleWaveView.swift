//
//  HXBSingleWaveView.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/20.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBSingleWaveView: UIView {
    
    /// 波浪的高度 【默认40】
    static var waveHeight = CGFloat(40)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let random = Double(arc4random()).truncatingRemainder(dividingBy: Double(5))
        speed = (random / 10 + 0.5) * 0.03
        offsetX = speed * Double(bounds.width * 0.2)
        
        
        waveLayer.frame = bounds
        waveLayer.fillColor = UIColor(red: 251, green: 91, blue: 91).cgColor
        layer.addSublayer(waveLayer)
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateWave))
        displayLink.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Property
    fileprivate let waveLayer = CAShapeLayer()
    fileprivate var speed: Double = 0
    fileprivate var offsetX: Double = 0
}

extension HXBSingleWaveView {
    
    @objc fileprivate func updateWave() {
        
        let path = UIBezierPath()
        path.move(to: .zero)
        
        offsetX -= speed
        
        let A = HXBSingleWaveView.waveHeight * 0.5
        let ω = Double.pi / Double(bounds.width) * 2
        let k = bounds.height - A * 2
        let φ = offsetX
        for x in 0..<Int(bounds.width) {
            // y=Asin(ωx+φ)+k
            let y = A * CGFloat(sin(ω * Double(x) + φ)) + k
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
        }
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: .zero)
        path.close()
        
        waveLayer.path = path.cgPath
    }
}
