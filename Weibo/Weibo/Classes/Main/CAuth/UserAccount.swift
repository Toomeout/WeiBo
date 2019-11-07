//
//  UserAccount.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/7.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
import Foundation
@objcMembers class UserAccount: NSObject {
    private let dateFormatter = DateFormatter()
    var access_token: String?
    var expires_in: TimeInterval = 0 {
        didSet {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            expires_data = dateFormatter.string(from: Date(timeIntervalSinceNow: expires_in))
        }
    }
    var uid: String?
    var expires_data: String?
    var avatar_large: String?
    var screen_name: String?
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    //重写该方法值为属性中有的键赋值
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    //重写description属性
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token", "expires_data", "uid", "screen_name", "avatar_large"]).description
    }
}
