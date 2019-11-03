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
        initComposeBtn()
    }
    override func viewWillAppear(_ animated: Bool) {
        for item in 0..<tabBar.items!.count {
            if (item == 2) {
                tabBar.items![item].isEnabled = false
                continue
            }
        }
    }

}
extension MainViewController {
    private func initComposeBtn() {
        tabBar.addSubview(composeBtn)
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.height/2)
    }
    
}
