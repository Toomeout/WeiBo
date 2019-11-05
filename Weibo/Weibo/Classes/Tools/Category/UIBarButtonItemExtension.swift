//
//  UIBarButtonItemExtension.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/4.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(image: String) {
        self.init()
        let btn = UIButton()
        btn.setImage(UIImage(named: image), for: .normal)
        btn.setImage(UIImage(named: image + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        customView = btn
    }
}
