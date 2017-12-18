//
//  HXBRequestApi.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation

class HXBRequestApi {
    init() { }
    
    // MARK: - Request
    
    /// 原始请求
    var request: URLRequest?
    /// 请求方法
    var requestMethod: HXBHttpMethod = .get
    /// 请求url
    var requestUrl: String?
    /// 请求baseUrl
    var baseUrl: String? = "http://api.hoomxb.com"
    /// 请求参数
    var params: HXBRequestParam?
    /// 请求超时
    var timeout: TimeInterval = 30
    /// 请求头
    var requestHeaderFields: HXBRequestHeader?
    
    // MARK: - Response
    
    /// 原始响应
    var httpResponse: HTTPURLResponse?
    /// 响应状态码
    var statusCode: Int? {
        return httpResponse?.statusCode
    }
    /// 响应头
    var responseHeaderFields: [String : Any]? {
        return httpResponse?.allHeaderFields as? [String : Any]
    }
    /// 响应错误
    var error: Error?
    /// 响应结果
    var responseObject: HXBResponseObject?
    
    // MARK: -
    /// 请求任务
    var dataTask: URLSessionDataTask?
    
    // MARK: - Callback
    var completeCallback: HXBRequestCallBack?
    
    // MARK: - HUD
    
    /// Toast 和 Progress 的代理
    weak var hudDelegate: HXBNetworkHUDDelegate?
    /// Toast 显示容器类型
    var hudShowToastType: HXBHudContainerType = .view
    /// Progress 显示容器类型
    var hudShowProgressType: HXBHudContainerType = .view
    
    /// 请求适配器
    var adapter: HXBRequestAdapter?
}

// MARK: - HUD Method
extension HXBRequestApi {
    
    /// 显示 Progress
    func showProgress(type: HXBHudContainerType) {
        hudDelegate?.showProgress(type: type)
    }
    
    /// 隐藏 Progress
    func hideProgress(type: HXBHudContainerType) {
        hudDelegate?.hideProgress(type: type)
    }
    
    /// 显示 Toast
    ///
    /// - Parameter toast: toast
    func show(toast: String, type: HXBHudContainerType) {
        hudDelegate?.show(toast: toast, type: type)
    }
}

