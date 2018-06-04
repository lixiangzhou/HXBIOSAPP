//
//  HXBTimerCountingTool.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/30.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class HXBTimerCountingTool {
    fileprivate var timer: Timer?
    var timerCount = 59
    let (timerSignal, timerObserver) = Signal<Int, NoError>.pipe()
    
    func startTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timerCount = 59
        timerObserver.send(value: timerCount)
        timer = Timer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func countDown() {
        timerCount -= 1
        if timerCount <= 0 {
            timerObserver.send(value: 0)
            stopTimer()
        } else {
            timerObserver.send(value: timerCount)
        }
    }
}
