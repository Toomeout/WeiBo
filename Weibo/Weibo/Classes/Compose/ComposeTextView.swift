//
//  ComposeTextView.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/21.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {
    lazy var placeHolderLabel: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //初始化通常在这里
        setUI()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //通常如果增加子控件的时候在此方法中操作
        
    }
}

extension ComposeTextView {
    private func setUI() {
        addSubview(placeHolderLabel)
        placeHolderLabel.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
        }
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        placeHolderLabel.text = "分享新鲜事..."
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)//设置内边距
    }
}
