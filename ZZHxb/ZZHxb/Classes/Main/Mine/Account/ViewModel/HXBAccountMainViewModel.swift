//
//  HXBAccountMainViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBAccountMainViewModel: HXBViewModel {
    var dataSource: [[HXBAccountMainCellViewModel]]
    override init() {
        dataSource = [
            [HXBAccountMainCellViewModel(title: "恒丰银行存管账户", rightAccessoryString: nil, imageName: nil)],
            
            [HXBAccountMainCellViewModel(title: "风险评测", rightAccessoryString: nil, imageName: nil),
             HXBAccountMainCellViewModel(title: "账户安全", rightAccessoryString: nil, imageName: nil),
             HXBAccountMainCellViewModel(title: "关于我们", rightAccessoryString: nil, imageName: nil)]
        ]
        super.init()
    }
    
    func signOut(completion: @escaping (Bool, String?) -> Void) {
        HXBNetwork.signout { (isSuccess, requestApi) in
            self.requestResult(isSuccess, requestApi, errorToast: "退出登录失败", completion: completion)
        }
    }
}
