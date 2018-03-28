//
//  HXBCommonFuncs.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/28.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

func checkInput(inputView: HXBInputFieldView, toastEmpty: String, toastCount: String, limitCount: Int = 0, min: Int = 0, max: Int = 0, toastView view: UIView) -> Bool {
    let text = inputView.text ?? ""
    if text.isEmpty {
        HXBHUD.show(toast: toastEmpty, in: view)
        return false
    }
    if limitCount > 0 { //  具体的限制
        if text.count != limitCount {
            HXBHUD.show(toast: toastCount, in: view)
            return false
        }
        return true
    } else {    // 范围限制
        if text.count >= min && text.count <= max {
            return true
        }
        HXBHUD.show(toast: toastCount, in: view)
        return false
    }
}
