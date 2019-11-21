//
//  WelcomeViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/9.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var iconViewbuttomCons: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileUrl = UserAccountViewModel.shareInstance.account?.avatar_large
        let url = URL(string: profileUrl ?? "")!
        iconView.setImageWith(url, placeholderImage: UIImage(named: "avatar_default_big"))
        iconViewbuttomCons.constant = UIScreen.main.bounds.height - UIScreen.main.bounds.height/4
        UIView.animate(withDuration: 3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0, options: [], animations: {
        }) { (Bool) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
