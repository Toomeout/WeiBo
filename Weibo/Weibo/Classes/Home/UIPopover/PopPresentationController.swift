//
//  PopPresentationController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/4.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class PopPresentationController: UIPresentationController {

    var popViewFrame: CGRect = CGRect(x: 100, y: 80, width: 200, height: 250)
    private lazy var coverView = UIView()
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = popViewFrame//设置弹出的视图大小
        setUpCoverView()
    }
}
//设置蒙版视图
extension PopPresentationController {
    private func setUpCoverView() {
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(coverClick))//为蒙版添加手势
        coverView.addGestureRecognizer(tapGes)
        containerView?.insertSubview(coverView, at: 0)
    }
}
//事件监听方法
extension PopPresentationController {
    @objc private func coverClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
