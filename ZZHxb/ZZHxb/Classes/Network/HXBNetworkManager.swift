//
//  HXBNetworkManager.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation
import Alamofire

typealias HXBRequestParam = Parameters
typealias HXBRequestHeader = HTTPHeaders
typealias HXBResponseObject = [String: Any]
typealias HXBHttpMethod = HTTPMethod
typealias HXBRequestCompletionCallBack = (Bool, HXBRequestApi, HXBResponseObject?, Error?) -> ()
/// 主要用于控制 HUD
typealias HXBRequestConfigClosrue = (HXBRequestApi) -> ()
typealias HXBRequestAdapter = (URLRequest) -> URLRequest?

class HXBNetworkManager {
    
    /// 单例
    static let shared = HXBNetworkManager()
    
    /// 参数编码
    private let encoding = URLEncoding.default
    /// session
    private let sessionManager = SessionManager.default
    
    private init() { }
    
    func send(requestApi: HXBRequestApi) {
        guard let url = getUrl(requestApi: requestApi) else {
            requestApi.completeCallback?(false, requestApi, nil, HXBNetworkError.requestUrlNil)
            return
        }
        
        do {
            var originRequest = URLRequest(url: url)
            
            originRequest.httpMethod = requestApi.requestMethod.rawValue
            originRequest.allHTTPHeaderFields = requestApi.requestHeaderFields
            originRequest.timeoutInterval = requestApi.timeout
            originRequest.httpShouldHandleCookies = false
            originRequest.allHTTPHeaderFields = getHeaderFields(requestApi: requestApi)
            
            let encodedRequest = try encoding.encode(originRequest, with: requestApi.params)
            
            requestApi.request = encodedRequest
            
            if let adaptedRequest = requestApi.adapter?(encodedRequest) {
                requestApi.request = adaptedRequest
            }
            
            requestApi.showProgress()
            HXBNetActivityManager.sendRequest()
            
            guard let request = requestApi.request else {
                requestApi.completeCallback?(false, requestApi, nil, HXBNetworkError.requestAdaptReturnNil)
                return
            }
            
            sessionManager.request(request).responseJSON { responseData in
                requestApi.hideProgress()
                HXBNetActivityManager.finishRequest()
                
                requestApi.httpResponse = responseData.response

                if responseData.result.isSuccess {
                    log.info(responseData.result.value!)
                    requestApi.responseObject = responseData.result.value as? HXBResponseObject
                } else {
                    log.error(responseData.error!)
                    requestApi.error = responseData.error
                }
                
                requestApi.completeCallback?(responseData.result.isSuccess, requestApi, requestApi.responseObject, responseData.error)
            }
        } catch {
            requestApi.completeCallback?(false, requestApi, nil, HXBNetworkError.encodingFailed(error: error))
        }
    }
}


// MARK: - Public
extension HXBNetworkManager {
    static func request(url: String, params: HXBRequestParam?, method: HXBHttpMethod = .get, configProgressAndToast: HXBRequestConfigClosrue? = nil, completionBlock: @escaping HXBRequestCompletionCallBack) {
        let requestApi = HXBRequestApi()
        requestApi.requestUrl = url
        requestApi.params = params
        requestApi.requestMethod = .get
        configProgressAndToast?(requestApi)
        self.request(requestApi: requestApi, completionBlock: completionBlock)
    }
    
    static func request(requestApi: HXBRequestApi, completionBlock: @escaping HXBRequestCompletionCallBack) {
        requestApi.completeCallback = completionBlock
        HXBNetworkManager.shared.send(requestApi: requestApi)
    }
}

// MARK: - Helper
extension HXBNetworkManager {
    fileprivate func getUrl(requestApi: HXBRequestApi) -> URL? {
        guard let requestUrl = requestApi.requestUrl else {
            return nil
        }
        
        var urlString = ""
        if let baseUrl = requestApi.baseUrl {
            urlString = baseUrl + requestUrl
        } else {
            urlString = HXBNetworkConfig.baseUrl + requestUrl
        }
        
        return URL(string: urlString)
    }
    
    fileprivate func getHeaderFields(requestApi: HXBRequestApi) -> HXBRequestHeader {
        var baseHeaderFields = HXBNetworkConfig.baseHeaderFields
        guard let headerFields = requestApi.requestHeaderFields else {
            return baseHeaderFields
        }
        for (key, value) in headerFields {
            baseHeaderFields[key] = value
        }
        return baseHeaderFields
    }
}
