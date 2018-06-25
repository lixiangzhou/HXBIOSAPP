//
//  HXBWebController.swift
//  ZZHxb
//
//  Created by lxz on 2018/2/24.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import WebKit
import WKWebViewJavascriptBridge

class HXBWebController: HXBViewController {
    
    convenience init(urlString: String) {
        self.init(nibName: nil, bundle: nil)
        self.urlString = urlString
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        loadWebView()
        initBridge()
    }

    // MARK: - Public Property
    var urlString: String?
    // MARK: - Private Property
    fileprivate var webView: WKWebView!
    var bridge: WKWebViewJavascriptBridge!
    
    fileprivate var progressView = HXBNavBarProgressView()
}

// MARK: - UI
extension HXBWebController {
    fileprivate func setUI() {
        let webViewConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: webViewConfig)
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        progressView.backgroundColor = hxb.color.mostImport
        view.addSubview(progressView)
        
        progressView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(2)
        }
        
        webView.snp.makeConstraints { maker in
            maker.top.equalTo(progressView)
            maker.left.right.bottom.equalToSuperview()
        }
        
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
}

// MARK: - Action
extension HXBWebController {
    
}

// MARK: - Network
extension HXBWebController {
    func loadWebView() {
        var request = URLRequest(url: URL(string: urlString!)!)
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] ?? ""
        let userAgent = "\(UIDevice.current.zz_version)/IOS \(UIDevice.current.systemVersion)/v\(version) iphone"
        request.setValue(HXBKeychain[hxb.keychain.key.token], forHTTPHeaderField: HXBNetworkConfig.tokenKey)
        request.setValue(userAgent, forHTTPHeaderField: HXBNetworkConfig.userAgent)
        
        webView.load(request)
    }
}

// MARK: - Delegate Internal

// MARK: -
extension HXBWebController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        HXBNetActivityManager.sendRequest()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        HXBNetActivityManager.finishRequest()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        HXBNetActivityManager.finishRequest()
    }
}

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension HXBWebController {
    fileprivate func processProgress() {
        let duration = 0.25
        let needHide = webView.estimatedProgress == 1
        
        UIView.animate(withDuration: duration, animations: {
            self.progressView.progress = CGFloat(self.webView.estimatedProgress)
        }, completion: { (_) in
            
        })
        
        if needHide {
            UIView.animate(withDuration: duration, animations: {
                self.progressView.alpha = 0
            }, completion: { (_) in
                self.progressView.progress = 0
            })
        } else {
            self.progressView.alpha = 1
        }
        print(webView.estimatedProgress)
    }
}

// MARK: - Other
extension HXBWebController {
    fileprivate func initBridge() {
        bridge = WKWebViewJavascriptBridge(webView: webView)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            title = webView.title
        } else if keyPath == "estimatedProgress" {
            processProgress()
        }
    }
}

// MARK: - Public
extension HXBWebController {
    
}



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


