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
    /// 设置了此属性，并且设置了 RequestApi 的 hudDelegate，并且 HXBHudContainerType != .none，才有hud
    weak var progressContainerView: UIView?
    /// 设置了此属性，并且设置了 RequestApi 的 hudDelegate，并且 HXBHudContainerType != .none，才有toast
    weak var toastContainerView: UIView?
    
    convenience init(progressContainerView: UIView? = nil, toastContainerView: UIView? = nil) {
        self.init()
        
        self.progressContainerView = progressContainerView
        self.toastContainerView = toastContainerView
    }
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
    func requestResult(_ isSuccess: Bool, _ requestApi: HXBRequestApi, errorToast: String? = hxb.string.getdataErrorString, showToast: Bool = true, completion: @escaping (Bool) -> Void) {
        
        if isSuccess {
            let json = JSON(requestApi.responseObject!)
            if json.isSuccess {
                completion(true)
            } else {
                show(toast: json.message, canShow: showToast, requestApi: requestApi)
                completion(false)
            }
        } else {
            show(toast: errorToast, canShow: showToast, requestApi: requestApi)
            completion(false)
        }
    }
    
    func show(toast: String?, canShow: Bool, requestApi: HXBRequestApi) {
        if canShow && toast != nil {
            requestApi.show(toast: toast!)
        }
    }
}
