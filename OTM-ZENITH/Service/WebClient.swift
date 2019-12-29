//
//  WebClient.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 22/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebClient: NSObject {

    var targetURL: URL?
    let webView: WKWebView = WKWebView()
    var completion: ((URL?) -> Void)!
    
    override init() {
        self.webView.frame = UIScreen.main.bounds
        self.webView.translatesAutoresizingMaskIntoConstraints = false
    }

    func handle(_ url: URL, completion: @escaping (URL?) -> Void) {
        targetURL = url
        self.webView.navigationDelegate = self
        self.completion = completion
        loadAddressURL()
    }
    
    func loadAddressURL() {
        guard let url = targetURL else {
            return
        }
        let req = URLRequest(url: url)
        DispatchQueue.main.async {
            self.webView.load(req)
        }
    }
}

// MARK: delegate

extension WebClient: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // here we handle internally the callback url and call method that call handleOpenURL (not app scheme used)
        if let url = navigationAction.request.url , url.host == "api.media.atlassian.com" {
            
            (UIApplication.shared.delegate as! AppDelegate).applicationHandle(url: url)
            decisionHandler(.cancel)
            
            completion(url)
            return
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(error)")
        completion(nil)
        // maybe cancel request...
    }
    /* override func webView(webView: WebView!, decidePolicyForNavigationAction actionInformation: [NSObject : AnyObject]!, request: URLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
     
     if request.URL?.scheme == "otm-zenith" {
     self.dismissWebViewController()
     }
     
     } */
}
