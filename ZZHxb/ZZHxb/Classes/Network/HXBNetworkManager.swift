//
//  HXBNetworkManager.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ReactiveSwift
import Result

typealias HXBRequestParam = Parameters
typealias HXBRequestHeader = HTTPHeaders
typealias HXBResponseObject = [String: Any]
typealias HXBHttpMethod = HTTPMethod
typealias HXBRequestResult = (Bool, HXBRequestApi)
typealias HXBRequestCompletionCallBack = (Bool, HXBRequestApi) -> ()

/// 主要用于控制 HUD
typealias HXBRequestConfigClosrue = (HXBRequestApi) -> ()

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
            requestApi.error = HXBNetworkError.requestUrlNil
            requestApi.completeCallback?(false, requestApi)
            return
        }
        
        do {
            // 构建请求
            var originRequest = URLRequest(url: url)
            
            originRequest.httpMethod = requestApi.requestMethod.rawValue
            originRequest.timeoutInterval = requestApi.timeout
            originRequest.httpShouldHandleCookies = false
            originRequest.allHTTPHeaderFields = getHeaderFields(requestApi: requestApi)
            
            // 请求参数编码
            let encodedRequest = try encoding.encode(originRequest, with: requestApi.params)
            requestApi.request = encodedRequest
            
            // HUD
            requestApi.showProgress()
            HXBNetActivityManager.sendRequest()
            
            if requestApi.responseSerializeType == .json {
                // 发送请求
                sessionManager.request(requestApi.request!).responseJSON { responseData in
                    // HUD
                    requestApi.hideProgress()
                    HXBNetActivityManager.finishRequest()
                    
                    requestApi.httpResponse = responseData.response
                    
                    if responseData.result.isSuccess {
                        log.info(responseData.result.value!)
                        requestApi.responseObject = responseData.result.value as? HXBResponseObject
                        
                        self.successProcess(requestApi: requestApi, withObserver: nil)
                    } else {
                        log.error(responseData.error!)
                        requestApi.error = responseData.error
                        
                        self.errorProcess(requestApi: requestApi, withObserver: nil)
                    }
                }
            } else if requestApi.responseSerializeType == .data {
                sessionManager.request(requestApi.request!).responseData(completionHandler: { responseData in
                    // HUD
                    requestApi.hideProgress()
                    HXBNetActivityManager.finishRequest()
                    
                    requestApi.httpResponse = responseData.response
                    
                    if responseData.result.isSuccess {
                        log.info(responseData.result.value!)
                        requestApi.responseData = responseData.result.value
                        
                        self.successProcess(requestApi: requestApi, withObserver: nil)
                    } else {
                        log.error(responseData.error!)
                        requestApi.error = responseData.error
                        
                        self.errorProcess(requestApi: requestApi, withObserver: nil)
                    }
                })
            }
        } catch {
            requestApi.error = HXBNetworkError.encodingFailed(error: error)
            requestApi.completeCallback?(false, requestApi)
        }
    }
    
    func rac_send(requestApi: HXBRequestApi) ->  SignalProducer<HXBRequestResult, NoError> {
        return SignalProducer<HXBRequestResult, NoError> { [weak self] (observer, lifetime) in
            guard let url = self!.getUrl(requestApi: requestApi) else {
                requestApi.error = HXBNetworkError.requestUrlNil
                observer.send(value: (false, requestApi))
                observer.sendCompleted()
                return
            }
         
            do {
                // 构建请求
                var originRequest = URLRequest(url: url)
                
                originRequest.httpMethod = requestApi.requestMethod.rawValue
                originRequest.timeoutInterval = requestApi.timeout
                originRequest.httpShouldHandleCookies = false
                originRequest.allHTTPHeaderFields = self!.getHeaderFields(requestApi: requestApi)
                
                // 请求参数编码
                let encodedRequest = try self!.encoding.encode(originRequest, with: requestApi.params)
                requestApi.request = encodedRequest
                
                // HUD
                requestApi.showProgress()
                HXBNetActivityManager.sendRequest()
                
                if requestApi.responseSerializeType == .json {
                    // 发送请求
                    self!.sessionManager.request(requestApi.request!).responseJSON { responseData in
                        // HUD
                        requestApi.hideProgress()
                        HXBNetActivityManager.finishRequest()
                        
                        requestApi.httpResponse = responseData.response
                        
                        if responseData.result.isSuccess {
                            log.info(responseData.result.value!)
                            requestApi.responseObject = responseData.result.value as? HXBResponseObject
                            
                            self!.successProcess(requestApi: requestApi, withObserver: observer)
                        } else {
                            log.error(responseData.error!)
                            requestApi.error = responseData.error
                            
                            self!.errorProcess(requestApi: requestApi, withObserver: observer)
                        }
                    }
                } else if requestApi.responseSerializeType == .data {
                    self!.sessionManager.request(requestApi.request!).responseData(completionHandler: { responseData in
                        // HUD
                        requestApi.hideProgress()
                        HXBNetActivityManager.finishRequest()
                        
                        requestApi.httpResponse = responseData.response
                        
                        if responseData.result.isSuccess {
                            log.info(responseData.result.value!)
                            requestApi.responseData = responseData.result.value
                            
                            self!.successProcess(requestApi: requestApi, withObserver: observer)
                        } else {
                            log.error(responseData.error!)
                            requestApi.error = responseData.error
                            
                            self!.errorProcess(requestApi: requestApi, withObserver: observer)
                        }
                    })
                }
            } catch {
                requestApi.error = HXBNetworkError.encodingFailed(error: error)
                observer.send(value: (false, requestApi))
            }
        }
    }
}


// MARK: - Public
extension HXBNetworkManager {
    static func request(url: String, params: HXBRequestParam? = nil, method: HXBHttpMethod = .get, responseSerializeType: HXBRequestApi.ResponseSerializeType = .json, configRequstClosure: HXBRequestConfigClosrue? = nil, completionClosure: @escaping HXBRequestCompletionCallBack) {
        let requestApi = HXBRequestApi()
        requestApi.requestUrl = url
        requestApi.params = params
        requestApi.requestMethod = method
        requestApi.responseSerializeType = responseSerializeType
        configRequstClosure?(requestApi)
        self.request(requestApi: requestApi, completionClosure: completionClosure)
    }
    
    static func request(requestApi: HXBRequestApi, completionClosure: @escaping HXBRequestCompletionCallBack) {
        requestApi.completeCallback = completionClosure
        HXBNetworkManager.shared.send(requestApi: requestApi)
    }

    static func rac_request(url: String, params: HXBRequestParam? = nil, method: HXBHttpMethod = .get, responseSerializeType: HXBRequestApi.ResponseSerializeType = .json, configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        let requestApi = HXBRequestApi()
        requestApi.requestUrl = url
        requestApi.params = params
        requestApi.requestMethod = method
        requestApi.responseSerializeType = responseSerializeType
        configRequstClosure?(requestApi)
        return rac_request(requestApi: requestApi)
    }
    
    static func rac_request(requestApi: HXBRequestApi) -> SignalProducer<HXBRequestResult, NoError> {
        return HXBNetworkManager.shared.rac_send(requestApi: requestApi)
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
            urlString = HXBNetworkConfig.shared.baseUrl + requestUrl
        }
        
        return URL(string: urlString)
    }
    
    fileprivate func getHeaderFields(requestApi: HXBRequestApi) -> HXBRequestHeader {
        var baseHeaderFields = HXBNetworkConfig.baseHeaderFields
        baseHeaderFields[HXBNetworkConfig.tokenKey] = HXBKeychain[hxb.keychain.key.token] ?? ""
        guard let headerFields = requestApi.requestHeaderFields else {
            return baseHeaderFields
        }
        for (key, value) in headerFields {
            baseHeaderFields[key] = value
        }
        return baseHeaderFields
    }
}

// MARK: - Result Process
extension HXBNetworkManager {
    fileprivate func errorProcess(requestApi: HXBRequestApi, withObserver: Signal<HXBRequestResult, NoError>.Observer?) {
        let errorFinish = {
            if let observer = withObserver {
                observer.send(value: (false, requestApi))
            } else {
                requestApi.completeCallback?(false, requestApi)
            }
        }
        
        if requestApi.statusCode == hxb.code.tokenInvalid { // token 失效，重新请求 token，
            self.tokenRequest(completion: { isSuccess in
                if isSuccess {  // 成功后重新发送请求
                    self.send(requestApi: requestApi)
                } else {    // 失败就调用回调
                    hxb.notification.notLogin.post()
                    errorFinish()
                }
                withObserver?.sendCompleted()
            })
        } else if requestApi.statusCode == hxb.code.notLogin {  // 未登录
            hxb.notification.notLogin.post()
            errorFinish()
            withObserver?.sendCompleted()
        } else {
            errorFinish()
            withObserver?.sendCompleted()
        }
    }
    
    fileprivate func successProcess(requestApi: HXBRequestApi, withObserver: Signal<HXBRequestResult, NoError>.Observer?) {
        if let observer = withObserver {
            let respObj = JSON(requestApi.responseObject!)
            if respObj.isSuccess {
                observer.send(value: (true, requestApi))
            } else {
                observer.send(value: (false, requestApi))
            }
            observer.sendCompleted()
        } else {
            requestApi.completeCallback?(true, requestApi)
        }
    }
}

// MARK: - Token & Single Login
extension HXBNetworkManager {
    fileprivate func tokenRequest(completion: @escaping (Bool) -> ()) {
        Alamofire.request(HXBNetworkConfig.shared.baseUrl + hxb.api.token, method: .get, parameters: nil).responseJSON { responseObject in
            if responseObject.result.isSuccess {
                let json = JSON(responseObject.result.value as! HXBResponseObject)
                let token = json["data"]["token"].stringValue
                HXBKeychain[hxb.keychain.key.token] = token
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
