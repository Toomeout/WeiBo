//
//  ComposeViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/21.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    private lazy var composeTitle = ComposeTitleView()
    private lazy var images = [UIImage]()
    @IBOutlet weak var textView: ComposeTextView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var picPickerCollectionView: PicPickerView!
    
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerHeightCons: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        //监听通知
        setNotifications()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)//移除监听器
    }
    
    @IBAction func picPickerBtnClick() {
        textView.resignFirstResponder()
        picPickerHeightCons.constant = UIScreen.main.bounds.height * 0.6
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
extension ComposeViewController {
    private func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendItemClick))
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.titleView = composeTitle
    }
    private func setNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardAppearance(_ :)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PicPicker), name: NSNotification.Name.init(picPickerId), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(delPic(note: )), name: NSNotification.Name.init(delPicPickerId), object: nil)
        
    }
    @objc private func KeyboardAppearance(_ note: Notification) {
        //获取动画执行时间
        let duration = note.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        //获取键盘最终的y值
        let endFrame = (note.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        var margin = UIScreen.main.bounds.height - y - 34//工具栏距离底部的位置
        margin = margin <= 0 ? margin + 34 :margin
        toolBarBottomCons.constant = margin
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()//刷新布局
        }
    }
    @objc private func PicPicker() {
        //检查系统图片选择器是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        let pic = UIImagePickerController()
        pic.sourceType = .photoLibrary
        pic.delegate = self
        present(pic, animated: true, completion: nil)
    }
    @objc private func delPic(note: Notification) {
        guard let image = note.object as? UIImage else {
            return
        }
        guard let index = images.firstIndex(of: image) else {
            return
        }
        images.remove(at: index)
        picPickerCollectionView.images = images
    }
}
//监听事件
extension ComposeViewController {
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    @objc private func sendItemClick() {
        
    }
}
//图片选择器代理方法
extension ComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        images.append(img)
        picPickerCollectionView.images = self.images
        picker.dismiss(animated: true, completion: nil)
    }
}
//TextView代理方法
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
