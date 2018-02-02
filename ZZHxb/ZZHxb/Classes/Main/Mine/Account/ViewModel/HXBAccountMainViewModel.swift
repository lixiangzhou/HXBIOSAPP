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
        
        let headerViewModel = HXBAccountMainCellViewModel(title: HXBAccountModel.shared.userInfo.username)
        
        headerViewModel.titleSignal = HXBAccountViewModel.shared.usernameSignal.combineLatest(with: HXBAccountViewModel.shared.avatarSignal).map({ (username, image) -> NSAttributedString in
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -2, width: 32, height: 32)
            let attrTxt = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
            attrTxt.append(NSAttributedString(string: "  \(username)", attributes: [NSAttributedStringKey.baselineOffset: 8]))
            return attrTxt
        })

        let bankAccountViewModel = HXBAccountMainCellViewModel(title: "恒丰银行存管账户")
        let bankViewModel = HXBAccountMainCellViewModel(title: "银行卡")
        
        bankAccountViewModel.rightAccessoryStringSignal = HXBAccountViewModel.shared.bankOpenSignal.combineLatest(with: HXBAccountViewModel.shared.transitionPwdSignal)
            .map { hasBank, hasTransitionPwd in return hasBank && hasTransitionPwd ? hxb.color.linkActivity : hxb.color.mostImport }
            .combineLatest(with: HXBAccountViewModel.shared.bankInfoStateSignal).map({ (color, string) -> NSAttributedString in
            return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor: color])
        })
        
        bankViewModel.rightAccessoryStringSignal = HXBAccountViewModel.shared.bandCardSignal.map { hasBankCard in
            if hasBankCard {
                return NSAttributedString(string: "已绑定", attributes: [NSAttributedStringKey.foregroundColor: hxb.color.linkActivity])
            } else {
                return NSAttributedString(string: "未绑定", attributes: [NSAttributedStringKey.foregroundColor: hxb.color.mostImport])
            }
        }
        
        let riskViewModel = HXBAccountMainCellViewModel(title: "风险评测")
        let accountSecureViewModel = HXBAccountMainCellViewModel(title: "账户安全")
        let advisorViewModel = HXBAccountMainCellViewModel(title: "我的财富顾问")
        let aboutViewModel = HXBAccountMainCellViewModel(title: "关于我们")
        
        riskViewModel.rightAccessoryStringSignal = HXBAccountViewModel.shared.account.userInfo.reactive.producer(forKeyPath: "riskType").map { type in
            let typeString = type as! String
            let color = typeString == "立即评测" ? hxb.color.mostImport : hxb.color.linkActivity
            return NSAttributedString(string: typeString, attributes: [.foregroundColor: color])
        }
        
        let group1 = [headerViewModel]
        var group2: [HXBAccountMainCellViewModel]!
        var group3: [HXBAccountMainCellViewModel]!
        
        HXBAccountViewModel.shared.bankOpenSignal.combineLatest(with: HXBAccountViewModel.shared.advisorSignal).startWithValues { [weak self] (hasBank, hasAdvisor) in
            group2 = hasBank ? [bankAccountViewModel, bankViewModel] : [bankAccountViewModel]
            group3 = hasAdvisor
                ? [riskViewModel, accountSecureViewModel, advisorViewModel, aboutViewModel]
                : [riskViewModel, accountSecureViewModel, aboutViewModel]
            self?.dataSource = [group1, group2, group3]
        }
    }
    
    /// 登出账户
    ///
    /// - Parameter completion: 完成回调 Bool 是否完成, String toast
    func signOut(completion: @escaping (Bool, String?) -> Void) {
        HXBNetwork.signout { (isSuccess, requestApi) in
            self.requestResult(isSuccess, requestApi, errorToast: "退出登录失败", completion: completion)
        }
    }
}
