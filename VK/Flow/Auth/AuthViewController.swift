//
//  AuthViewController.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var webView: WKWebView!
    
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        webView.navigationDelegate = self
        
        let color = UIColor(red: 235/255, green: 237/255, blue: 240/255, alpha: 1)
        self.webView.isOpaque = false
        self.webView.backgroundColor = color
        self.webView.scrollView.backgroundColor = color
        
        guard var components = URLComponents(string: AppConfig.Authentication.url) else {
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: AppConfig.Authentication.id),
            URLQueryItem(name: "redirect_uri", value: ""),
            URLQueryItem(name: "scope", value: "friends"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: AppConfig.Api.version),
            URLQueryItem(name: "display", value: "mobile")
        ]
        
        if let url = components.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    
    // MARK: - Initializers
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view.backgroundColor = UIColor(red: 90/255, green: 129/255, blue: 180/255, alpha: 1)
    }
}
