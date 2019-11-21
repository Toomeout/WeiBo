//
//  PicViewCell.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/18.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class PicViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    var imageUrl: URL? {
        didSet {
            guard let url = imageUrl else {
                return
            }
            itemImageView.setImageWith(url, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
