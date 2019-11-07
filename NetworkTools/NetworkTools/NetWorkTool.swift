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
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
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
//请求accesstoken
extension NetWorkTool {
    func loadAccessToken(_ code: String, finish: @escaping (_ result: [String: Any]?, _ error: Error?) -> ()) {
        let parameters = ["client_id": appKey, "client_secret": appSecret, "grant_type": "authorization_code", "redirect_uri": redirectUri, "code": code]
        request(method: .POST, urlString: accessToken, paramters: parameters) { (result, error) in
            finish((result as? [String : Any]), error)
        }
    }
    func loadUserInfo(access_token: String, uid: String, finish: @escaping (_ result: [String: Any]?, _ error: Error?) -> ()) {
        let parameters = ["access_token": access_token, "uid": uid]
        NetWorkTool.shareInstance.request(method: .GET, urlString: userUrl, paramters: parameters) { (result, error) in
            finish(result as? [String : Any], error)
        }
    }
}
