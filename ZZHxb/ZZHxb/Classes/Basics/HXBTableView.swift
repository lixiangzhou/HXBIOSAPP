//
//  HXBTableView.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/14.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import UIKit

class HXBTableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
