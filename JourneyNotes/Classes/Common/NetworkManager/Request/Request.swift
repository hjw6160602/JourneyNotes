//
//  Request.swift
//  LvmmModel
//
//  Created by 贺嘉炜 on 2017/1/4.
//  Copyright © 2017年 Nee. All rights reserved.
//

import XCTest
import AFNetworking

class Request: NSObject {
    
    /// generate 生成请求参数
    ///
    /// - Parameter api: 请求接口的method
    /// - Returns: 请求完成之后的闭包
    static func generate(api: String, resource: String) -> (url: String, method: String, params:[String:  String]) {
        let index = AnalyzingTool.indexOfItemFromPlist(resource: resource, api: api)
        return AnalyzingTool.paramsFromPlist(resource: resource, index: index)
    }
    
    
    /// request
    ///
    /// - Parameters:
    ///   - api: 请求接口的method
    ///   - finished: 请求完成之后的闭包
    static func request(_ api: String, resource: String, finished:@escaping ((_ data:Any?) -> Void))  {
        var (url, method, params) = Request.generate(api: api, resource: resource)
        //将参数尾巴拼接上去
        params = TailTool().requestParams(paramDict: params, check: false, { (dict) in
            dict["method"] = method
        })
        print("最终的请求URL：\n\(url + params.flatmapOfDict)")
        
        Request.post(url: url, paramms: params, timeout: 20) { (response, error) in
            guard error != nil else{
                var data:Any?
                if response is Dictionary<String, Any> {
                    let responseDict = response as!
                        Dictionary<String, Any>
                    print("服务器返回结果：\n\(responseDict)")
                    let code = responseDict["code"] as! String
                    if code == "1"{
                        data = responseDict["data"]
                    }
                }
                finished(data)
                return
            }
        }
    }
    
    static func post(url:String, paramms:[String:String], timeout:TimeInterval, closure:@escaping (_ responseObject:Any, _ error:Error?) -> ()) {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = timeout
        manager.responseSerializer.acceptableContentTypes = ["text/plain","text/html","application/json"]
        manager.post(url, parameters: paramms, progress: { (_) in
        }, success: { (task, responseObject) in
            //关闭网络标志
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let responseObject = responseObject {
                closure(responseObject, "" as? Error)
            }
        }) { (task, error) in
            closure("", error)
        }
    }

}
