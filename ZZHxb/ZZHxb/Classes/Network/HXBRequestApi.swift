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
    var baseUrl: String?
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
    var finishCallback: HXBRequestCallBack?
}
