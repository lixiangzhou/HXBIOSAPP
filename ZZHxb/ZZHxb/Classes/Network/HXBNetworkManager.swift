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
typealias HXBRequestCallBack = (Bool, HXBRequestApi, HXBResponseObject?, Error?) -> ()

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
            // URL错误
            return
        }
        
        do {
            var originRequest = URLRequest(url: url)
            
            originRequest.httpMethod = requestApi.requestMethod.rawValue
            originRequest.allHTTPHeaderFields = requestApi.requestHeaderFields
            originRequest.timeoutInterval = requestApi.timeout
            
            let encodedRequest = try encoding.encode(originRequest, with: requestApi.params)
            
            requestApi.request = encodedRequest
            
            sessionManager.request(encodedRequest).responseJSON { responseData in
                requestApi.httpResponse = responseData.response

                if responseData.result.isSuccess {
                    requestApi.responseObject = responseData.result.value as? HXBResponseObject
                } else {
                    requestApi.error = responseData.error
                }
                
                requestApi.finishCallback?(responseData.result.isSuccess, requestApi, requestApi.responseObject, responseData.error)
            }
        } catch {
            // 编码出错
        }
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
            urlString = NetworkConfig.baseUrl + requestUrl
        }
        
        return URL(string: urlString)
    }
}
