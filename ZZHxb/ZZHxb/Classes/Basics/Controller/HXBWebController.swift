//
//  HXBWebController.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/24.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import WebKit

class HXBNavBarProgressView: UIView {
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        var rect = CGRect(origin: rect.origin, size: rect.size)
        rect.size.width *= progress
        let path = UIBezierPath(rect: rect)
        backgroundColor?.setFill()
        path.fill()
    }
}

class HXBWebController: HXBViewController {
    
    convenience init(urlString: String) {
        self.init(nibName: nil, bundle: nil)
        self.urlString = urlString
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Public Property
    var urlString: String?
    // MARK: - Private Property
    fileprivate var webView: WKWebView!
    
    fileprivate var progressView = HXBNavBarProgressView()
}

// MARK: - UI
extension HXBWebController {
    fileprivate func setUI() {
        progressView.backgroundColor = hxb.color.mostImport
        view.addSubview(progressView)
        
        let webViewConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: webViewConfig)
        
        view.addSubview(webView)
        
        progressView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(2)
        }
        
        webView.snp.makeConstraints { maker in
            maker.top.equalTo(progressView.snp.bottom)
            maker.left.right.bottom.equalToSuperview()
        }
        
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        webView.load(URLRequest(url: URL(string: urlString!)!))
    }
}

// MARK: - Action
extension HXBWebController {
    
}

// MARK: - Network
extension HXBWebController {
    
}

// MARK: - Delegate Internal

// MARK: -


// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBWebController {

}

// MARK: - Other
extension HXBWebController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            title = webView.title
        } else if keyPath == "estimatedProgress" {
            let duration = 0.25
            let needHide = webView.estimatedProgress == 1
            if needHide {
                UIView.animate(withDuration: duration, animations: {
                    self.progressView.alpha = 0
                }, completion: { (_) in
                    self.progressView.progress = 0
                })
            } else {
                print(webView.estimatedProgress)
                UIView.animate(withDuration: duration, animations: {
                    self.progressView.progress = CGFloat(self.webView.estimatedProgress)
                }, completion: { (_) in
                    
                })
            }
        }
    }
}

// MARK: - Public
extension HXBWebController {
    
}

