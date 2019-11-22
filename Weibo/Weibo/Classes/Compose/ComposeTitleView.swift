//
//  ComposeTitleView.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/21.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
import SnapKit
class ComposeTitleView: UIView {
    private lazy var titleLabel = UILabel()
    private lazy var screenName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComposeTitleView {
    private func setUpUI() {
        addSubview(titleLabel)
        addSubview(screenName)
        //设置frame
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        screenName.snp_makeConstraints { (make) in
            make.centerX.equalTo(titleLabel.snp_centerX)
            make.top.equalTo(titleLabel.snp_bottom).offset(3)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        screenName.font = UIFont.systemFont(ofSize: 14)
        screenName.textColor = UIColor.lightGray
        
        titleLabel.text = "发微博"
        screenName.text = UserAccountViewModel.shareInstance.account?.screen_name
    }
}
