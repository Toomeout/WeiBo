//
//  MainViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/3.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    //private lazy var composeBtn: UIButton = UIButton.createButton(image: "tabbar_compose_icon_add", bgImage: "tabbar_compose_button")
    private lazy var composeBtn: UIButton = UIButton(image: "tabbar_compose_icon_add", bgImage: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()
        //initComposeBtn()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for item in 0..<tabBar.items!.count {
            if (item == 2) {
                tabBar.items![item].isEnabled = false
                continue
            }
        }
        initComposeBtn()
    }

}
//设置UI界面扩展
extension MainViewController {
    private func initComposeBtn() {
        tabBar.addSubview(composeBtn)//必须在viewWillAppear方法中调用防止按钮被覆盖导致按钮无法接受事件
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.height/2)
        composeBtn.addTarget(self, action: #selector(composeClick), for: .touchUpInside)
    }
}
//事件监听扩展
/*
 事件监听的本质是发送消息发送消息是oc的特性
 将方法包装成@SEL-->勒种查找方法--》e根据@sel找到imp指针
 如果方法定义成private后方法不会添加到方法列表中除非在private前添加@objc才会将该方法添加到方法列表中
 */
extension MainViewController {
    @objc private func composeClick() {
        let composeController = ComposeViewController()
        let composeNav = UINavigationController(rootViewController: composeController)
        present(composeNav, animated: true, completion: nil)
    }
}
