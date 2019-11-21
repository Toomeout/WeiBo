//
//  UserAccount.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/7.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
import Foundation
@objcMembers class UserAccount: NSObject, NSCoding {

    var access_token: String?
    var expires_in: TimeInterval = 0 {
        didSet {
            expires_data = Date(timeIntervalSinceNow: expires_in)
        }
    }
    var uid: String?
    var expires_data: Date?
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
    
    //归档与解档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_data, forKey: "expires_data")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_data = aDecoder.decodeObject(forKey: "expires_data") as? Date
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
}
