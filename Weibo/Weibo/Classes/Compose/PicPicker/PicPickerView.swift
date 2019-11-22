//
//  PicPickerViewController.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/22.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

private let reuseIdentifier = "picPickerCell"
private let padding = 10
class PicPickerView: UICollectionView{
    var images: [UIImage] = [UIImage]() {
        didSet {
            reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate = self
        dataSource = self
        register(UINib.init(nibName: "PicPickerCell", bundle: .main), forCellWithReuseIdentifier: reuseIdentifier)
    }

}
extension PicPickerView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PicPickerCell
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wh = (Int(UIScreen.main.bounds.width) - 4 * padding)/3
        return CGSize(width: wh, height: wh)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
