//
//  HXBRiskAssessmentController.swift
//  ZZHxb
//
//  Created by lxz on 2018/3/29.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

//enum HXBRiskAssessmentNextTo: String {
//    case simpleBack = "简单返回"
//    case popToAccountMain = "返回账户信息页面"
//}

class HXBRiskAssessmentController: HXBWebController {

    // MARK: - Life Cycle
    
//    convenience init(nextTo: HXBRiskAssessmentNextTo) {
//        self.init(nibName: nil, bundle: nil)
//        self.nextTo = nextTo
//    }
    
    override func viewDidLoad() {
        urlString = hxb.api.risk_assessment
        super.viewDidLoad()
        
        setRightTop()
        setBridge()
    }

    // MARK: - Public Property
//    var nextTo: HXBRiskAssessmentNextTo!
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension HXBRiskAssessmentController {
    fileprivate func setRightTop() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIButton(title: "跳过", font: hxb.font.transaction, titleColor: hxb.color.white, target: self, action: #selector(skip)))
    }
}

// MARK: - Action
extension HXBRiskAssessmentController {
    @objc fileprivate func skip() {
        bridge.call(handlerName: "skipTest")
    }
}

// MARK: - Helper
extension HXBRiskAssessmentController {
    fileprivate func setBridge() {
        bridge.register(handlerName: "riskEvaluation") { (data, callBack) in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Other
extension HXBRiskAssessmentController {
    
}

// MARK: - Public
extension HXBRiskAssessmentController {
    
}

