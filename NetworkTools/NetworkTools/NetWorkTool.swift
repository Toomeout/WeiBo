//
//  NetWorkTool.swift
//  NetworkTools
//
//  Created by 李喜明 on 2019/11/6.
//  Copyright © 2019 李喜明. All rights reserved.
//

import UIKit
import AFNetworking
enum RequestType : Int{
    case POST = 0
    case GET = 1
}
class NetWorkTool: AFHTTPSessionManager {
    static let shareInstance: NetWorkTool = {
        let tool = NetWorkTool()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tool
    }()//swif单利模式 let是线程安全的
}
//封装网络方法
extension NetWorkTool {
    func request(method: RequestType, urlString: String, paramters: [String: Any], finished: @escaping (_ responseObj: Any?, _ error: Error?) -> ()) {
        //成功回调
        let successCallback = { (task: URLSessionDataTask, responseObj: Any?) in
            finished(responseObj, nil)
        }
        //失败回调
        let failureCallback = { (task: URLSessionDataTask?, error: Error) in
            finished(nil, error)
        }
        if method == RequestType.GET {
            get(urlString, parameters: paramters, progress: nil, success: successCallback, failure: failureCallback)
        } else if method == RequestType.POST {
            post(urlString, parameters: paramters, progress: nil, success: successCallback, failure: failureCallback)
        }
    }
}
