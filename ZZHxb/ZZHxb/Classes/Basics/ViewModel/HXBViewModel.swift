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

extension HXBViewModel {
    func requestResult(_ isSuccess: Bool, _ requestApi: HXBRequestApi, errorToast: String?, completion: @escaping (Bool, String?) -> Void) {
        if isSuccess {
            let json = JSON(requestApi.responseObject!)
            if json.isSuccess {
                completion(true, nil)
            } else {
                completion(false, json.message)
            }
        } else {
            completion(false, errorToast)
        }
    }
}
