//
//  HXBAccountViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/1.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import HandyJSON
import ReactiveSwift
import Result

class HXBAccountViewModel: HXBViewModel {
    static let shared = HXBAccountViewModel()
    
    private(set)var account = HXBAccountModel.shared
    
    // MARK: - 信号
    
    /// 用户姓名
    let usernameSignal: SignalProducer<String, NoError>
    
    /// 头像信息
    let avatarSignal: SignalProducer<UIImage, NoError>
    
    /// 银行存管信息状态
    let depositoryStateInfoSignal: SignalProducer<String, NoError>
    
    /// 银行存管是否开通
    let depositoryOpenSignal: SignalProducer<Bool, NoError>
    
    /// 是否有交易密码
    let transitionPwdSignal: SignalProducer<Bool, NoError>
    
    /// 是否绑定银行卡
    let bandCardSignal: SignalProducer<Bool, NoError>
    
    /// 是否有理财顾问
    let advisorSignal: SignalProducer<Bool, NoError>
    
    // MARK: -
    
    /// 开通存管账户
    var hasDepositoryOpen: Bool {
        return account.userInfo.isCreateEscrowAcc == "1"
    }
    
    /// 是否绑定银行卡
    var hasBindCard: Bool {
        return account.userInfo.hasBindCard == "1"
    }

    private override init() {
        usernameSignal = account.userInfo.reactive.producer(forKeyPath: "username").map { $0 as! String }.skipRepeats()
        
        avatarSignal = account.userInfo.reactive.producer(forKeyPath: "gender").map { gender -> UIImage in
            guard let gender = gender as? String else {
                return UIImage("default_avatar")!
            }
            if gender == "" {
                return UIImage("default_avatar")!
            } else if gender == "0" {
                return UIImage("mine_man")!
            } else {
                return UIImage("mine_woman")!
            }
        }.skipRepeats()

        depositoryOpenSignal = account.userInfo.reactive.producer(forKeyPath: "isCreateEscrowAcc").map { $0 as! String == "1" }.skipRepeats()
        
        transitionPwdSignal = account.userInfo.reactive.producer(forKeyPath: "isCashPasswordPassed").map { $0 as! String == "1" }.skipRepeats()
        
        depositoryStateInfoSignal = depositoryOpenSignal.combineLatest(with: transitionPwdSignal).map { (openBank, hasTransitionPwd) -> String in
            if openBank {
                return hasTransitionPwd ? "已开通" : "完善信息"
            } else {
                return "未开通"
            }
        }.skipRepeats()
        
        bandCardSignal = account.userInfo.reactive.producer(forKeyPath: "hasBindCard").map { $0 as! String == "1" }.skipRepeats()
        
        advisorSignal = account.userInfo.reactive.producer(forKeyPath: "isDisplayAdvisor").map { $0 as! Bool }.skipRepeats()
        
        super.init()
    }
}
extension HXBAccountViewModel {
    /// 更新用户信息
    func updateUserInfo(completion: @escaping HXBCommonCompletion) {
        HXBNetwork.updateUserInfo { isSuccess, requestApi in
            if isSuccess {
                if let data = requestApi.responseObject?["data"] as? HXBResponseObject,
                    let userAssets = data["userAssets"] as? HXBResponseObject,
                    let userInfo = data["userInfo"] as? HXBResponseObject {
                    JSONDeserializer.update(object: &self.account.userAssets, from: userAssets)
                    JSONDeserializer.update(object: &self.account.userInfo, from: userInfo)
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    /// 成功了才执行回调，否则不执行
    func updateUserInfoSuccess(_ completion: @escaping () -> ()) {
        updateUserInfo { isSuccess in
            if isSuccess {
                completion()
            }
        }
    }
    
    func updateUserInfo() {
        updateUserInfo { (_) in
        }
    }
}
