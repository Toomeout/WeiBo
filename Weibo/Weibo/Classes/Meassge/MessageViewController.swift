//
//  MessageViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/10/31.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    let tip = "登录后，别人评论你的微博，给你发消息，都会在这里显示"
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.setUpVisitorView(homeView: "visitordiscover_image_message", tip: tip)
        visitorView.rotateView.isHidden = true
    }
}
