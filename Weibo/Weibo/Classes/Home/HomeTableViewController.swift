//
//  HomeTableViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/10/31.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
class HomeTableViewController: BaseViewController {

    let titleBtn: TitleButton = TitleButton()
    
    private lazy var popoverAnimator:  PopoverAnimator = PopoverAnimator { [weak self] (isPop) in
        self?.titleBtn.isSelected = isPop
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.addRotateAnimate()
        guard isLogin else {
            return
        }
        //登录后设置导航栏l内容
        setUpNavigstion()
    }
}
//设置home界面的navigation的UI
extension HomeTableViewController {
    //设置登录后的navigation内容
    private func setUpNavigstion() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: "navigationbar_pop")
        titleBtn.setTitle("coderwhy", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
        
    }
}
//监听方法
extension HomeTableViewController {
    @objc private func titleBtnClick(titleButton: TitleButton) {
        titleButton.isSelected = !titleButton.isSelected
        let popView = PopViewController()
        popView.modalPresentationStyle = .custom//保证跳转视图的底层视图不被移除
        popView.transitioningDelegate = popoverAnimator//设置转场代理实现自定义转场
        popoverAnimator.popViewFrame = CGRect(x: 100, y: 80, width: 200, height: 250)
        present(popView, animated: true, completion: nil)
    }
}
