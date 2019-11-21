//
//  HomeCell.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/17.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
import SDWebImage
class HomeCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var picUrlView: PicCollectionView!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var retweetedText: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var retweentTextTopCons: NSLayoutConstraint!
    @IBOutlet weak var picViewTopCons: NSLayoutConstraint!
    @IBOutlet weak var buttomViewTopCons: NSLayoutConstraint!
    
    let padding: Int = 5
    let margin: Int = 10
    
    var viewModel: StatusViewModel? {
        didSet {
            guard let statusViewModel = viewModel else {
                return
            }
            // 2.设置头像
            iconImageView.setImageWith(statusViewModel.profileURL!, placeholderImage: UIImage(named: "avatar_default"))
            // 3.设置昵称
            screenNameLabel.text = statusViewModel.status?.user?.screen_name
            // 4.设置时间
            timeLabel.text = statusViewModel.createDateText
            // 5.设置来源
            sourceLabel.text = statusViewModel.sourceText
            // 6.设置认证图片
            verifiedImageView.image = statusViewModel.verifiedImage
            // 7.设置会员图片
            vipImageView.image = statusViewModel.vipView
            // 8.设置昵称的颜色
            screenNameLabel.textColor = statusViewModel.vipView != nil ? UIColor.orange: UIColor.black
            // 9.设置微博正文
            contentLabel.text = statusViewModel.status?.text
            //设置图片
            picUrlView.picUrls = statusViewModel.picUrls
            //设置collectionView的d高度
            picViewHCons.constant = calculateHeight(count: picUrlView.picUrls.count).height
            
            if let statuses = statusViewModel.status?.retweeted_status {
                let screenName = statuses.user?.screen_name ?? ""
                let text = statuses.text ?? ""
                retweetedText.text = "@\(screenName): \(text)"
                shadowView.isHidden = false
                retweentTextTopCons.constant = 15
            } else {
                retweetedText.text = nil
                shadowView.isHidden = true
                retweentTextTopCons.constant = 0
                picViewTopCons.constant = 10
                buttomViewTopCons.constant = 10
            }
        }
    }
    
    func calculateHeight(count: Int) -> CGSize{
        let width = Int(UIScreen.main.bounds.width) - 2 * margin
        let itemHeight = (width - 2 * padding) / 3
        if count == 0 {
            return CGSize(width: width, height: 0)
        }
        if count == 1 {
            let image = SDImageCache.shared.imageFromDiskCache(forKey: viewModel?.picUrls.first?.absoluteString)
            if let img = image {
                return CGSize(width: img.size.width, height: img.size.height)
            }
        }
        if count <= 2 {
            return CGSize(width: width, height: (width - padding) / 2)
        }
        if count <= 4 {
            return CGSize(width: width, height: width)
        }
        let rows = (count - 1)/3 + 1
        let height = rows * itemHeight + (rows - 1) * padding
        return CGSize(width: width, height: height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
