//
//  PopoverAnimator.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/5.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    var isPop = true
    var popViewFrame = CGRect(x: 100, y: 80, width: 200, height: 250)
    var callBack: ((_ isSelected: Bool) -> ())?
    init(callBack: @escaping (Bool) -> ()) {
        super.init()
        self.callBack = callBack
    }
    
}
//遵守转场协议
extension PopoverAnimator: UIViewControllerTransitioningDelegate {
    //目的改变弹出框尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let popviewController = PopPresentationController(presentedViewController: presented, presenting: presenting)
        popviewController.popViewFrame = popViewFrame
        return popviewController
        
    }
    //自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPop = true
        callBack!(isPop)
        return self
    }
    //自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPop = false
        callBack!(isPop)
        return self
    }
}
//弹出小时动画代理方法
extension PopoverAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    //获取转场动画的上下文
    //
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPop ? popPresentView(transitionContext: transitionContext) : disPresentView(transitionContext: transitionContext)
    }
    func popPresentView(transitionContext: UIViewControllerContextTransitioning) {
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        transitionContext.containerView.addSubview(presentView)
        presentView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        presentView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            presentView.transform = CGAffineTransform.identity
        }) { (isFinished) -> Void in
            transitionContext.completeTransition(true)
        }
        
    }
    func disPresentView(transitionContext: UIViewControllerContextTransitioning) {
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            dismissView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        }) { (isFinished) -> Void in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}
