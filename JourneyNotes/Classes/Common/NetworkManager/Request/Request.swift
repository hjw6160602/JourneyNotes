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
    /// request
    ///
    /// - Parameters:
    ///   - api: 请求接口的method
    ///   - finished: 请求完成之后的闭包
    static func request(_ api: String, resource: String, finished:@escaping ((_ data:Any?) -> Void))  {
        
        let mathod: String = "search/MixedItem/?"
        let url = host + page + mathod
        
        //将参数尾巴拼接上去
        let params = [
            "filter" : ["keyword":"清水寺", "mddid":""],
            "start" : 0
            ] as [String : Any]
        
        print("最终的请求URL：\n\(url + params.flatmapOfDict)")
        
        self.post(url: url, params: params as! [String : String], timeout: 20) { (response, error) in
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
