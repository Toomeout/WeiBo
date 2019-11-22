//
//  PicPickerCell.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/22.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class PicPickerCell: UICollectionViewCell {

    @IBOutlet weak var picImageButton: UIButton!
    @IBOutlet weak var deletePicClick: UIButton!
    var image: UIImage? {
        didSet {
            if image != nil {
                picImageButton.setImage(image, for: .normal)
                picImageButton.isUserInteractionEnabled = false
                deletePicClick.isHidden = false
            } else {
                picImageButton.setImage(UIImage(named: "compose_pic_add"), for: .normal)
                picImageButton.isUserInteractionEnabled = true
                deletePicClick.isHidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func addPicClick() {
        //通过通知的方式弹出系统照片选择器
        NotificationCenter.default.post(name: Notification.Name.init(picPickerId), object: nil)
    }
    @IBAction func delPicClick() {
        NotificationCenter.default.post(name: Notification.Name.init(delPicPickerId), object: image)
    }
}
