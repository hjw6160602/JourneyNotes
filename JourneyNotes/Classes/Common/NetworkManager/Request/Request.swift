//
//  Request.swift
//  LvmmModel
//
//  Created by 贺嘉炜 on 2017/1/4.
//  Copyright © 2017年 Nee. All rights reserved.
//

import Alamofire

class AlamofireRequest: NSObject {
    static let host = "https://mapi.mafengwo.cn/"
    static let page = "rest/app/"
    
    /// filterRequest
    ///
    /// - Parameters:
    ///   - keyword: 请求接口的关键词
    ///   - finished: 请求完成之后的闭包
    static func filterRequest(keyword: String, finished:@escaping ((_ data:Any?) -> Void) ) {
        // 搜索参数：
        let method = "search/MixedItem/?"
        let filter = "{\"keyword\":\"" + keyword + "\",\"mddid\":\"\"}"
        let jsonData = "{\"filter\":" + filter + ",\"start\":\"0\"}"
        print(jsonData)
        
//         {"filter":{"keyword":"清水寺","mddid":""},"start":"0"}
        
        
        var params = ["jsonData" : jsonData,
                      "x_auth_mode" : "client_auth",
            "oauth_signature": "1/pLM9AnTKsliccPZ%2BhkkhXN9Nk%3D"]
        
        self.request(method, params: &params) { (data) in
            finished(data)
        }
    }
    
    /// request
    ///
    /// - Parameters:
    ///   - method: 请求接口的method
    ///   - params: 请求的参数
    ///   - finished: 请求完成之后的闭包
    static func request(_ method: String, params: inout [String: String], finished:@escaping ((_ data:Any?) -> Void))  {
        let url = host + page + method

        let tail = TailTool().tailDict
        // 将参数尾巴拼接上去
        params += tail
        
        print("最终的请求URL：\n\(url + params.flatmapOfDict)")
        
        self.post(url: url, params: params , timeout: 20) { (response, error) in
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
    
    /** Alamofire方式发送网络请求 */
    static func post(url:String, params:[String:String], timeout:TimeInterval, closure:@escaping (_ responseObject:Any, _ error:Error?) -> ()) {
        Alamofire.request(url, method: .post, parameters: params).responseData { (data) in
            print(data)
        }
    }
    
    /** AFN方式发送网络请求 */
//    static func post(url:String, params:[String:String], timeout:TimeInterval, closure:@escaping (_ responseObject:Any, _ error:Error?) -> ()) {
//        let manager = AFHTTPSessionManager()
//        manager.requestSerializer.timeoutInterval = timeout
//        manager.responseSerializer.acceptableContentTypes = ["text/plain","text/html","application/json"]
//        manager.post(url, parameters: paramms, progress: { (_) in
//        }, success: { (task, responseObject) in
//            //关闭网络标志
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            if let responseObject = responseObject {
//                closure(responseObject, "" as? Error)
//            }
//        }) { (task, error) in
//            closure("", error)
//        }
//    }

}
