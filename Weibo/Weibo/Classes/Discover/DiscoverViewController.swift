//
//  DiscoverViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/10/31.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {
    let tip = "登录后，别人b评论你的微博，给你发消息，你都会在这里接受到通知"
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.setUpVisitorView(homeView: "visitordiscover_image_profile", tip: tip)
        visitorView.rotateView.isHidden = true
    }
}
