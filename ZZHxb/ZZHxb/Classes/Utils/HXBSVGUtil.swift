//
//  HXBSVGUtil.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/13.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Macaw

struct HXBSVGUtil {
    private static let svgView = SVGView(frame: CGRect.zero)
    static func parse(src: String) -> UIImage {
        svgView.frame.size = CGSize(width: 100, height: 100)
        svgView.fileName = src
        return svgView.zz_snapshotImage()
    }
}
