//
//  User.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/10.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

@objcMembers class User: NSObject{

    var profile_image_url: String?
    var screen_name: String?
    var verified_type: Int = -1
    var mbrank: Int = 0
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["profile_image_url", "screen_name", "verified_type", "mbrank"]).description
    }
}
