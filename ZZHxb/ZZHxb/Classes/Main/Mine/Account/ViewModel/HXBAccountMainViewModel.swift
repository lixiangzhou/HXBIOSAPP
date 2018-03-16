//
//  HXBAccountMainViewModel.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/16.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class HXBAccountMainViewModel: HXBViewModel {
    var dataSource = [[HXBAccountMainCellViewModel]]()
    override init() {
        super.init()
        
        let headerViewModel = HXBAccountMainCellViewModel(type: .username)
        
        headerViewModel.titleSignal = HXBAccountViewModel.shared.usernameSignal.combineLatest(with: HXBAccountViewModel.shared.avatarSignal).map({ (username, image) -> NSAttributedString in
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -2, width: 32, height: 32)
            let attrTxt = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
            attrTxt.append(NSAttributedString(string: "   \(username)", attributes: [NSAttributedStringKey.baselineOffset: 8]))
            return attrTxt
        })

        let depositoryAccountViewModel = HXBAccountMainCellViewModel(type: .depositoryAccount)
        let bankViewModel = HXBAccountMainCellViewModel(type: .bank)
        
        depositoryAccountViewModel.rightAccessoryStringSignal = HXBAccountViewModel.shared.depositoryOpenSignal.combineLatest(with: HXBAccountViewModel.shared.transitionPwdSignal)
            .map { hasBank, hasTransitionPwd in return hasBank && hasTransitionPwd ? hxb.color.linkActivity : hxb.color.mostImport }
            .combineLatest(with: HXBAccountViewModel.shared.depositoryStateInfoSignal).map({ (color, string) -> NSAttributedString in
            return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor: color])
        })
        
        bankViewModel.rightAccessoryStringSignal = HXBAccountViewModel.shared.bandCardSignal.map { hasBankCard in
            if hasBankCard {
                return NSAttributedString(string: "已绑定", attributes: [NSAttributedStringKey.foregroundColor: hxb.color.linkActivity])
            } else {
                return NSAttributedString(string: "未绑定", attributes: [NSAttributedStringKey.foregroundColor: hxb.color.mostImport])
            }
        }
        
        let riskViewModel = HXBAccountMainCellViewModel(type: .risk)
        let accountSecureViewModel = HXBAccountMainCellViewModel(type: .accountSecure)
        let advisorViewModel = HXBAccountMainCellViewModel(type: .advisor)
        let aboutViewModel = HXBAccountMainCellViewModel(type: .about)
        
        riskViewModel.rightAccessoryStringSignal = HXBAccountViewModel.shared.account.userInfo.reactive.producer(forKeyPath: "riskType").map { type in
            let typeString = type as! String
            let color = typeString == "立即评测" ? hxb.color.mostImport : hxb.color.linkActivity
            return NSAttributedString(string: typeString, attributes: [.foregroundColor: color])
        }
        
        let group1 = [headerViewModel]
        var group2: [HXBAccountMainCellViewModel]!
        var group3: [HXBAccountMainCellViewModel]!
        
        HXBAccountViewModel.shared.depositoryOpenSignal.combineLatest(with: HXBAccountViewModel.shared.advisorSignal).startWithValues { [weak self] (hasBank, hasAdvisor) in
            group2 = hasBank ? [depositoryAccountViewModel, bankViewModel] : [depositoryAccountViewModel]
            group3 = hasAdvisor
                ? [riskViewModel, accountSecureViewModel, advisorViewModel, aboutViewModel]
                : [riskViewModel, accountSecureViewModel, aboutViewModel]
            self?.dataSource = [group1, group2, group3]
        }
    }
    
    /// 登出账户
    func signOut(completion: @escaping HXBCommonCompletion) {
        HXBNetwork.signout(configRequstClosure: { requestApi in
            requestApi.hudDelegate = self
        }) { isSuccess, requestApi in
            self.requestResult(isSuccess, requestApi, completion: completion)
        }
    }
}
