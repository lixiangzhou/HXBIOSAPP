//
//  HXBHomeController.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/12.
//Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import Alamofire
import HandyJSON
import SwiftyJSON

class HXBHomeController: HXBViewController {

    var signal: SignalProducer<Bool, NoError>!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        signal = SignalProducer<Bool, NoError> { (observer, lifetime) in
//            Alamofire.request(HXBNetworkConfig.shared.baseUrl + hxb.api.token, method: .get, parameters: nil).responseJSON { responseObject in
//                if responseObject.result.isSuccess {
//                    let json = JSON(responseObject.result.value as! HXBResponseObject)
//                    let token = json["data"]["token"].stringValue
//                    HXBKeychain[hxb.keychain.key.token] = token
//                    observer.send(value: true)
//                } else {
//                    observer.send(value: false)
//                }
//            }
//        }
        
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
}

// MARK: - UI
extension HXBHomeController {
    fileprivate func setUI() {
        showBack = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        signal.startWithValues { (value) in
//            print(value)
//        }
//        HXBNavigationController(rootViewController: HXBSignInController()).presentFrom(controller: self, animated: true)
        
//        HXBDepositoryOpenOrModifyController().pushFrom(controller: self, animated: true)
        
//        HXBAccountModel.shared.userInfo.zz_printPropertyValues()
//        
//        HXBAccountViewModel.shared.updateUserInfo()
    }
}

// MARK: - Action
extension HXBHomeController {
    
}

// MARK: - Network
extension HXBHomeController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBHomeController {
    
}

// MARK: - Other
extension HXBHomeController {
    
}

// MARK: - Public
extension HXBHomeController {
    
}
