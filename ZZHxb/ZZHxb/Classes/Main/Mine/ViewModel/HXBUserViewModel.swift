//
//  HXBUserViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/1.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import HandyJSON

class HXBUserViewModel: HXBModel {
    static let shared = HXBUserViewModel()
    
    private(set)var user = HXBUserModel()
    
    /// 更新用户信息
    ///
    /// - Parameter completion: 完成回调 Bool 是否完成
    func updateUserInfo(completion: @escaping (Bool) -> ()) {
        HXBNetwork.updateUserInfo { (isSuccess, requestApi) in
            if isSuccess {
                if let data = requestApi.responseObject?["data"] as? HXBResponseObject,
                let userAssets = data["userAssets"] as? HXBResponseObject,
                let userInfo = data["userInfo"] as? HXBResponseObject {
                    JSONDeserializer.update(object: &self.user.userAssets, from: userAssets)
                    JSONDeserializer.update(object: &self.user.userInfo, from: userInfo)
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
}
