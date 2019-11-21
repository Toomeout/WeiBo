//
//  UserAccountTool.swift
//  Weibo
//
//  Created by 李喜明 on 2019/11/9.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
class UserAccountViewModel{
    static let shareInstance: UserAccountViewModel = UserAccountViewModel()
    var accountPath: String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("accont.plist")
    }
    var account: UserAccount?
    var isLogin: Bool {
        if account == nil {
            return false
        }
        guard let expiresDate = account?.expires_data else {
            return false
        }
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
        
    }
    init() {
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
}
