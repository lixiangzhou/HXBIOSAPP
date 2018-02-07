//
//  HXBBankListViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/6.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import HandyJSON

class HXBBankListViewModel: HXBViewModel {
    var dataSource = [HXBBankModel]()
    
    /// 获取银行列表
    func getBankList(completion: @escaping HXBCommonCompletion) {
        HXBNetwork.getBankList(configProgressAndToast: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi) { isSuccess in
                if isSuccess {
                    if let data = requestApi.responseObject!["data"] as? HXBResponseObject,
                        let dataList = data["dataList"] as? [HXBResponseObject] {
                        self.dataSource = [HXBBankModel].deserialize(from: dataList)! as! [HXBBankModel]
                    }
                }
                completion(isSuccess)
            }
        }
    }
}
