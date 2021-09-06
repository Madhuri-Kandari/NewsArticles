//
//  WebArticleViewController.swift
//  NewsAppAssignment
//
//  Created by M1066900 on 27/08/21.
//

import UIKit
import WebKit

class WebArticleViewController:UIViewController, WKNavigationDelegate, WKUIDelegate{
    
    var url:String?
    var titleDetail:String?
    let webView = WKWebView(frame: .zero)
    var activityIndicator = UIActivityIndicatorView()
    
    init(url: String, titleDetail:String){
        self.url = url
        self.titleDetail = titleDetail
        super.init(nibName: nil, bundle: nil)
    }

    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleDetail
        configureWebView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
//MARK:-Webview for loading the url onto WebArticleVC when clicked any row in MenuController
    func configureWebView(){
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        guard let url = url else{
            return
        }
        showSpinner()
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
//MARK:- activity indicator for loading
    func showSpinner(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
    }
    
    func isAnimating(showIndicator:Bool){
        if showIndicator{
            activityIndicator.startAnimating()
        }
        else{
            activityIndicator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isAnimating(showIndicator: false)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isAnimating(showIndicator: true)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        isAnimating(showIndicator: false)
    }
}
