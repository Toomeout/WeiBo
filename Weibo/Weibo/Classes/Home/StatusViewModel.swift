//
//  StatusViewModel.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/10.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {

    var status: Status?
    
    var sourceText: String?
    var createDateText: String?
    
    var verifiedImage: UIImage?
    var profileURL: URL?
    var vipView: UIImage?
    
    var picUrls: [URL] = [URL]()//处理配图
    
    init(status: Status) {
        super.init()
        self.status = status
        //处理来源
        doSourceText()
        //创建时间处理了
        doCreateDateText()
        //认证图片处理
        doVerifiedImage()
        //会员等级处理
        doMbrankImage()
        //处理头像
        doProfileUrl()
        //处理配图
        doPicUrls()
    }
}
extension StatusViewModel {
    func doSourceText() {
        guard let ziyuan = self.status?.source, ziyuan != "" else {
            return
        }
        //字符串截取
        let startIndex = (ziyuan as NSString).range(of: ">").location + 1
        let length = (ziyuan as NSString).range(of: "</").location - startIndex
        self.sourceText = (ziyuan as NSString).substring(with: NSRange(location: startIndex, length: length))
    }
    func doCreateDateText() {
        guard let createAt = self.status?.created_at else{
            return
        }
        self.createDateText = Date.createDateString(createAt: createAt)
    }
    func doVerifiedImage() {
        let verified_type = self.status?.user?.verified_type ?? -1
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
    }
    func doMbrankImage() {
        let mbrank = self.status?.user?.mbrank ?? 0
        if mbrank > 0, mbrank <= 6 {
            self.vipView = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
    }
    
    func doProfileUrl() {
        if let profileURLString = status?.user?.profile_image_url {
            profileURL = URL(string: profileURLString)
        }
    }
    func doPicUrls() {
        let picUrl = status?.pic_urls?.count != 0 ? status?.pic_urls : status?.retweeted_status?.pic_urls
        if let pics = picUrl {
            for pic in pics {
                guard let picString = pic["thumbnail_pic"] else {
                    continue
                }
                picUrls.append(URL(string: picString)!)
            }
        }
    }
}
