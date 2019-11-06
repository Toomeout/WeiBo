//
//  ViewController.swift
//  NetworkTools
//
//  Created by 李喜明 on 2019/11/6.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkTool.shareInstance.request(method: .GET, urlString: "http://httpbin.org/get", paramters: ["name": "liximing", "age": 18]) { (result, error) in
            if error != nil {
                print(error!)
                return
            }
            print(result!)
        }
    }
}

