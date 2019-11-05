//
//  VisitorView.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/3.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    @IBOutlet weak var rotateView: UIImageView!
    @IBOutlet weak var homeView: UIImageView!
    @IBOutlet weak var tipView: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    //通过xib创建的类方法
    class func visitorView() -> VisitorView{
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    func setUpVisitorView(homeView: String, tip: String) {
        self.homeView.image = UIImage(named: homeView)
        self.tipView.text = tip
        self.rotateView.isHidden = false
    }
    func addRotateAnimate() {
        //创建动画  CAkeyframeAnimate CABaseAnimate
        let rotateAni = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAni.fromValue = 0
        rotateAni.toValue = Double.pi * 2
        rotateAni.repeatCount = MAXFLOAT
        rotateAni.duration = 5
        rotateAni.isRemovedOnCompletion = false
        rotateView.layer.add(rotateAni, forKey: nil)
    }
}
