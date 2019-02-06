//
//  AuthViewController.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit
import WebKit

protocol AuthOutput {
    func reload(withUrlRequest request: URLRequest)
}

class AuthViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var webView: WKWebView!
    
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    
    var input: AuthInput?
    var finishFlow: (() -> Void)?
    
    
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        setupWebView()
        input?.didLoad()
    }
    
    
    // MARK: - Initializers
}


// MARK: - Fileprivate

extension AuthViewController {
    fileprivate func setupWebView() {
        webView.navigationDelegate = self
        
        let color = UIColor(red: 235/255, green: 237/255, blue: 240/255, alpha: 1)
        self.webView.isOpaque = false
        self.webView.backgroundColor = color
        self.webView.scrollView.backgroundColor = color
    }
}


// MARK: - AuthOutput

extension AuthViewController: AuthOutput {
    func reload(withUrlRequest request: URLRequest) {
        webView.load(request)
    }
}


// MARK: - WKNavigationDelegate

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view.backgroundColor = UIColor(red: 90/255, green: 129/255, blue: 180/255, alpha: 1)
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard
            let url = navigationAction.request.url,
            let result = input?.retrieveToken(fromUrl: url) else {
                
                decisionHandler(.allow)
                return
        }
        
        let decision: WKNavigationActionPolicy

        switch result {
        case .error:
            decision = .allow
        case .success(let token):
            decision = .cancel
            input?.retrieved(token: token)
            finishFlow?()
        }

        decisionHandler(decision)
    }
}
