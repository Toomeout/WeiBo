//
//  PicCollectionView.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/18.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
import SDWebImage
class PicCollectionView: UICollectionView {

    let padding: Int = 5
    let margin: Int = 10
    var picUrls: [URL] = [URL]() {
        didSet {
            reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
        delegate = self
        self.register(UINib.init(nibName: "PicViewCell", bundle: .main), forCellWithReuseIdentifier: "picViewCell")
    }

}

//d代理方法
extension PicCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picViewCell", for: indexPath) as! PicViewCell
        cell.imageUrl = picUrls[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 0
        var width = 0
        let wh = Int(UIScreen.main.bounds.width) - 2 * margin
        switch picUrls.count {
        case 1:
            let image = SDImageCache.shared.imageFromDiskCache(forKey: picUrls.first?.absoluteString)
            if let img = image {
                height = Int(img.size.height)
                width = Int(img.size.width)
            }
        case 2...4:
            height = (wh - padding)/2
            width = height
        case 5...9:
            height = (wh - 2 * padding)/3
            width = height
        default:
            height = 0
        }
        return CGSize(width: width, height: height)
    }
}
