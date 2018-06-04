//
//  HXBAlertController.swift
//  ZZHxb
//
//  Created by lxz on 2018/1/17.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

fileprivate let padding = 20
class HXBAlertController: UIViewController {

    // MARK: - Life Cycle
    /// 只能通过这种方式初始化。
    /// 如果有2个按钮，设置 leftActionName 和 rightActionName；
    /// 如果只有1个按钮，只设置 singleActionName
    /// 只要设置了 singleActionName，就会忽略 leftActionName，rightActionName
    convenience init(title: String? = nil, messageText: String? = nil, leftActionName: String? = nil, rightActionName: String? = nil, singleActionName: String? = nil) {
        self.init()
        
        modalPresentationStyle = .custom
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        transitioningDelegate = self
        
        setUI()
        
        if title == nil {
            titleLabel.snp.updateConstraints({ maker in
                maker.top.equalTo(0)
            })
        }
        titleLabel.text = title
        
        messageView.text = messageText
        if messageText == nil {
            messageView.snp.updateConstraints({ maker in
                maker.top.equalTo(titleLabel.snp.bottom).offset(0)
            })
        } else {
            var height = messageText!.zz_size(withLimitWidth: messageView.frame.width - 6, fontSize: messageView.font!.pointSize).height
            
            messageView.isScrollEnabled = height > 80
            
            height = min(80, height)
            messageView.snp.updateConstraints({ maker in
                maker.height.equalTo(height + messageView.font!.pointSize + 3)
            })
        }
        
        leftBtn.setTitle(leftActionName, for: .normal)
        rightBtn.setTitle(rightActionName, for: .normal)
        singleBtn.setTitle(singleActionName, for: .normal)
        
        let showSingle = singleActionName != nil && singleActionName!.count > 0
        
        leftBtn.isHidden = showSingle
        rightBtn.isHidden = showSingle
        singleBtn.isHidden = !showSingle
    }

    // MARK: - Public Property
    var singleAction: (() -> ())?
    var leftAction: (() -> ())?
    var rightAction: (() -> ())?
    var backClickDismissEnabled = true
    var textAlignment: NSTextAlignment {
        set {
            messageView.textAlignment = newValue
        }
        get {
            return messageView.textAlignment
        }
    }
    
    // MARK: - Private Property
    fileprivate let containerView = UIView()
    fileprivate let titleLabel = UILabel()
    fileprivate let messageView = UITextView()
    fileprivate let leftBtn = UIButton()
    fileprivate let rightBtn = UIButton()
    fileprivate let singleBtn = UIButton()
    fileprivate let backgroundBtn = UIButton()
    
    fileprivate var isPresent = true
}

// MARK: - UI
extension HXBAlertController {
    fileprivate func setUI() {
        view.addSubview(backgroundBtn)
        view.addSubview(containerView)
        
        containerView.backgroundColor = hxb.color.white
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.textColor = hxb.color.important
        
        messageView.font = hxb.font.transaction
        messageView.textAlignment = .center
        messageView.textColor = hxb.color.important
        messageView.isEditable = false
        messageView.isSelectable = false
        messageView.isScrollEnabled = false
        
        leftBtn.setTitleColor(hxb.color.normal, for: .normal)
        leftBtn.titleLabel?.font = hxb.font.mainContent
        leftBtn.backgroundColor = UIColor(stringHexValue: "e8e8ee")
        
        rightBtn.setTitleColor(hxb.color.white, for: .normal)
        rightBtn.titleLabel?.font = hxb.font.mainContent
        rightBtn.backgroundColor = hxb.color.mostImport
        
        singleBtn.setTitleColor(hxb.color.white, for: .normal)
        singleBtn.titleLabel?.font = hxb.font.mainContent
        singleBtn.backgroundColor = hxb.color.mostImport
        
        leftBtn.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
            self?.leftAction?()
        }
        
        rightBtn.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
            self?.rightAction?()
        }
        
        singleBtn.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
            self?.singleAction?()
        }
        
        backgroundBtn.reactive.controlEvents(.touchUpInside).observeValues { [weak self] _ in
            if self?.backClickDismissEnabled ?? true {
                self?.dismiss(animated: true, completion: nil)
            }
        }
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageView)
        containerView.addSubview(leftBtn)
        containerView.addSubview(rightBtn)
        containerView.addSubview(singleBtn)
        
        backgroundBtn.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.equalTo(280)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.left.equalTo(padding)
            maker.right.equalTo(-padding)
        }
        
        messageView.snp.makeConstraints { maker in
            maker.left.right.equalTo(titleLabel)
            maker.top.equalTo(titleLabel.snp.bottom).offset(CGFloat(padding) * 0.4)
            maker.height.equalTo(0)
        }
        
        leftBtn.snp.makeConstraints { maker in
            maker.left.bottom.equalToSuperview()
            maker.height.equalTo(hxb.size.wideButtonHeight)
        }
        
        rightBtn.snp.makeConstraints { maker in
            maker.right.bottom.equalToSuperview()
            maker.height.width.equalTo(leftBtn)
            maker.left.equalTo(leftBtn.snp.right)
        }
        
        singleBtn.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(leftBtn)
            maker.top.equalTo(messageView.snp.bottom).offset(CGFloat(padding))
        }
        
        view.layoutIfNeeded()
    }
}


// MARK: - Helper
extension HXBAlertController {
    static func phoneCall(phone: String = hxb.string.servicePhone, title: String?, message: String?, left: String = "取消", right: String = "拨打", isAsyncMain: Bool = false) {
        let vc = HXBAlertController(title: title, messageText: message, leftActionName: left, rightActionName: right)
        vc.textAlignment = .center
        vc.backClickDismissEnabled = false
        vc.rightAction = {
            UIApplication.shared.open(URL(string: "telprompt://\(phone)")!, options: [:], completionHandler: nil)
        }
        if isAsyncMain {
            DispatchQueue.main.async {
                HXBRootVCManager.shared.rootVC.present(vc, animated: true, completion: nil)
            }
        } else {
            HXBRootVCManager.shared.rootVC.present(vc, animated: true, completion: nil)
        }
    }
}


// MARK: - 转场动画相关
extension HXBAlertController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
}

extension HXBAlertController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresent ? 0.25 : 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
        }
        
        
        if isPresent {
            transitionContext.containerView.addSubview(toVC.view)
            toVC.view.alpha = 0
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toVC.view.alpha = 1
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        } else {
            transitionContext.containerView.addSubview(fromVC.view)
            fromVC.view.alpha = 1
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromVC.view.alpha = 0
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        }
    }
}
