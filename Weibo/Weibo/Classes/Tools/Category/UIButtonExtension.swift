//
//  UIButtonExtension.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/3.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
//扩展UIButton
extension UIButton {
    //增加类方法直接使用类名调用
    class func createButton(image: String, bgImage: String) -> UIButton {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: bgImage), for: .normal)
        btn.setBackgroundImage(UIImage(named: bgImage + "_highlighted"), for: .highlighted)
        btn.setImage(UIImage(named: image), for: .normal)
        btn.setImage(UIImage(named: image + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        return btn
    }
    //便利构造行数通常是对系统的构造函数进行扩充使用--推荐使用便利构造函数
    /*
     1、必须写在extension里面
     2、必须携带convenience关键字
     3、必须明确调用系统的init()构造函数
     */
    convenience init(image: String, bgImage: String) {
        self.init()
        setBackgroundImage(UIImage(named: bgImage), for: .normal)
        setBackgroundImage(UIImage(named: bgImage + "_highlighted"), for: .highlighted)
        setImage(UIImage(named: image), for: .normal)
        setImage(UIImage(named: image + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
}
