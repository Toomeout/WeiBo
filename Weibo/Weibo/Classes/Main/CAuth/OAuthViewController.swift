//
//  OAuthViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/7.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
class OAuthViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        loadPage()
        webView.navigationDelegate = self
    }
}
//设置UI
extension OAuthViewController{
    private func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillBtnClick))
        title = "登录页面"
    }
    private func loadPage() {
        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
//监听方法
extension OAuthViewController{
    @objc private func closeBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    @objc private func fillBtnClick() {
        //自定填充写js代码
        let jsCode = "document.getElementById('userId').value='1246893231@qq.com';document.getElementById('passwd').value='lxm1657783922'"
        webView.evaluateJavaScript(jsCode, completionHandler: nil)
    }
}
//设置WKWebView代理
extension OAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        guard let urlStr = url?.absoluteString else {
            decisionHandler(.cancel)
            return
        }
        if !urlStr.contains("code=") {
            decisionHandler(.allow)
            return
        }
        let arr = urlStr.components(separatedBy: "code=")
        loadAccessToken(code: arr[1])
        decisionHandler(.allow)//在发送请求后决定是否跳转
    }
}
//请求数据
extension OAuthViewController {
    private func loadAccessToken(code: String) {
        NetWorkTool.shareInstance.loadAccessToken(code) { (result, error) in
            if error != nil {
                return
            }
            guard let resultData = result else {
                print("没有获取数据")
                return
            }
            print(resultData)
            let person = UserAccount(dict: resultData)
            print(person)
        }
    }
    private func loadUserInfo(user: UserAccount) {
        guard let accessToken = user.access_token else {
            return
        }
        guard let uId = user.uid else {
            return
        }
        NetWorkTool.shareInstance.loadUserInfo(access_token: accessToken, uid: uId) { (result, error) in
            if error != nil {
                print(error as Any)
                return
            }
            guard let resultData = result else {
                print("没有获取数据")
                return
            }
            user.screen_name = resultData["screen_name"] as? String
            user.avatar_large = resultData["avatar_large"] as? String
            
        }
    }
}

