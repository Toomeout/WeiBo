//
//  ProfileViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/10/31.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.setUpVisitorView(homeView: "visitordiscover_image_profile", tip: "登录后才可以查看我的中心")
        visitorView.rotateView.isHidden = true
    }
}
