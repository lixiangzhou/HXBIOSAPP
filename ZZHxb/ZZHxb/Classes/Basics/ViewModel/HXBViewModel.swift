//
//  HXBViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/13.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import SwiftyJSON

class HXBViewModel: NSObject {
    weak var progressContainerView: UIView?
    weak var toastContainerView: UIView?
}

extension HXBViewModel: HXBNetworkHUDDelegate {
    func showProgress(type: HXBHudContainerType) {
        hudProgress(type: type) { toView in
            HXBHUD.showLoding(toView: toView)
        }
    }
    
    func hideProgress(type: HXBHudContainerType) {
        hudProgress(type: type) { toView in
            HXBHUD.hideLoding(forView: toView)
        }
    }
    
    func show(toast: String, type: HXBHudContainerType) {
        if let toView = hudToastView(type: type) {
            HXBHUD.show(toast: toast, in: toView)
        }
    }
}

extension HXBViewModel {
    fileprivate func hudToastView(type: HXBHudContainerType) -> UIView? {
        var toView: UIView?
        switch type {
        case .window:
            toView = UIApplication.shared.keyWindow
        case .view:
            toView = progressContainerView
        case .none:
            toView = nil
        }
        return toView
    }
    
    fileprivate func hudProgress(type: HXBHudContainerType, process: (UIView) -> ()) {
        var toView: UIView?
        switch type {
        case .window:
            toView = UIApplication.shared.keyWindow
        case .view:
            toView = progressContainerView
        case .none:
            toView = nil
        }
        if let toView = toView {
            process(toView)
        }
    }
}
