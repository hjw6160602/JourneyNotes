//
//  LvmmNetworkPort.swift
//  驴妈妈Swift
//
//  Created by SaiDicaprio on 2017/1/3.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit
import Alamofire

class LvmmNetworkPort: NSObject {
    open func postRequest(url:String, paramms:[String:String], closure:@escaping (_ responseObject:Any, _ error:Error?) -> ()) {

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let _ = Alamofire.SessionManager(configuration: configuration)
        
        Alamofire.request(url, parameters: paramms).responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            //关闭网络标志
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let responseObject = response.response {
                closure(responseObject, "" as? Error)
            }
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}
