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
            ZZHud.shared.show(loading: UIView(), loadingId: NSNotFound, toView: toView)
        }
    }
    
    func hideProgress(type: HXBHudContainerType) {
        hudProgress(type: type) { toView in
            ZZHud.shared.hideLoading(for: toView)
        }
    }
    
    func show(toast: String, type: HXBHudContainerType) {
        if let toView = hudToastView(type: type) {
            ZZHud.shared.show(message: toast, font: hxb.font.light, color: hxb.color.important, toView: toView)
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
