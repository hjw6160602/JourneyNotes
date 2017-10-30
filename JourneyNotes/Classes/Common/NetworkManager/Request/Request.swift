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
    
    
    static func loginRequest(finished:@escaping ((_ data:Any?) -> Void) ) {
        let method = "user/login"
        let userName = "hjw6160602@163.com"
        let password = "jx89580234"
        var params = ["x_auth_username": userName,
                      "x_auth_password": password,
                      "x_auth_mode": "client_auth",
                      "after_style": "default",
                      "put_style": "default"]
        let httpMehtod = HTTPMethod.POST
        self.request(method, httpMethod: httpMehtod, params: &params) { (data) in
            finished(data)
        }
    }
    
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
        var params = ["jsondata" : jsonData,
                      "x_auth_mode" : "client_auth",]
        let httpMehtod = HTTPMethod.GET
        self.request(method, httpMethod:httpMehtod,  params: &params) { (data) in
            finished(data)
        }
    }
    
    /// request
    ///
    /// - Parameters:
    ///   - method: 请求接口的method
    ///   - params: 请求的参数
    ///   - finished: 请求完成之后的闭包
    static func request(_ method: String, httpMethod: HTTPMethod, params: inout [String: String], finished:@escaping ((_ data:Any?) -> Void))  {
        let url = host + page + method

        params = TailTool().requestParams(url: url, httpMethod:httpMethod, params: params)

        //            print("最终的请求URL：\n\(url + params.flatmapOfDict)")
        
        self.post(url: url, params: params , timeout: 20) { (response, error) in
            guard error != nil else{
                if let json = response as? [String: Any] {
                    print("服务器返回结果：\n\(json)")
                    let rc = json["rc"] as! Int
//                    let rm = json["rm"] as! String
                    if rc == 0 {
                        let data = json["rm"]
                        finished(data)
                    }
                }
                return
            }
        }
    }
    
    /** Alamofire方式发送网络请求 */
    static func post(url:String, params:[String:String], timeout:TimeInterval, closure:@escaping (_ responseObject:Any, _ error:Error?) -> ()) {
        Alamofire.request(url, method: .post, parameters: params).responseJSON { (json) in
            closure(json.result.value!, nil)
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
