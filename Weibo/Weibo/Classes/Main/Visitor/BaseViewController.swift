//
//  BaseViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/3.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    var isLogin = UserAccountViewModel.shareInstance.isLogin
    lazy var visitorView: VisitorView = VisitorView.visitorView()
    override func loadView() {
        isLogin ? super.loadView() :setUpVisitorView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
    }
}
//设置UI界面
extension BaseViewController {
    private func setUpVisitorView() {
        view = visitorView
        visitorView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        
    }
    private func setUpNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginBtnClick))
    }
}
//事件监听
extension BaseViewController {
    @objc private func registerBtnClick() {
        print("register")
    }
    @objc private func loginBtnClick() {
        let oAuthViewController = OAuthViewController()
        
        let oAuthNavigation = UINavigationController(rootViewController: oAuthViewController)
        
        present(oAuthNavigation, animated: true, completion: nil)
    }
}
