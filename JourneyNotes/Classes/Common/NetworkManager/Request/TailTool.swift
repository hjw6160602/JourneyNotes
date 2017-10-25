//
//  TailTool.swift
//  驴妈妈Swift
//
//  Created by 贺嘉炜 on 2016/12/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

import UIKit


struct TailTool {
    let tailDict:[String : String] = {
        let networkType =  (Utils.mobileNetworkCode().characters.count > 0) ? Utils.mobileNetworkCode() : "WIFI"
        
        let secondChanel = SECOND_CHANNEL_VALUE
        // 这里直接传 蚂蜂窝的 固定版本号
//        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let version = "8.0.6"
        var debugStatus = "false"
        #if DEBUG // 判断是否在测试环境下
            debugStatus = "true"
        #endif
        let latitude = "31.238"
        let longitude = "121.403"
        
        let stamp = String(Date().timeStamp)
        
        let tailDict = ["mfwsdk_ver          : "20160401",
                        "o_lat"              : latitude,
                        "o_lng"              : longitude,
                        "oauth_consumer_key" : "4",
                        "oauth_nonce"        : "5cd35700-a835-435b-8b7f-af1b670f49ed",
                        "oauth_timestamp"    : "1508923282",
                        "oauth_token"        : "5450361_6e5238cf80d17ae9a883463db9c3f914",
                        "oauth_version"      : "1.0",
                        "open_udid"          : "56394509-A45F-4384-AE54-3986C2E68A58",
                        "screen_height"      : "1136",
                        "screen_scale"       : "2",
                        "screen_width"       : "640",
                        "sys_ver"            : "9.2",
                        "time_offset"        : "480",
                        "x_auth_mode"        : "client_auth" ]
//        "oauth_signature"  : "1/pLM9AnTKsliccPZ+hkkhXN9Nk"  : "",
//        "oauth_signature_method"  : "HMAC-SHA1",
        
        
        return tailDict
    }()
    
    public func requestParams(paramDict:[String : String], check:Bool, _ closure:((_ dict:inout [String: String]) -> ())?)-> [String : String]{
        var requestDict = ["":""]
        if let closure = closure {//如果是API请求
            //将API请求参数拼接上version和method字段
            requestDict = generateKeyDict(check, { ( tailDict ) in
                if let version = paramDict["version"]{
                    tailDict["version"] = version;
                }
                closure(&tailDict)
                //                print("需要拼接的参数：\(tailDict)")
            })
        } else{//CMS请求
            requestDict = generateKeyDict(check, nil)
        }
        
//        print("请求参数添加后\(requestDict)")
        //将参数字典拿出来，然后拼接上尾巴字典，然后返回
        requestDict += paramDict
//        print("请求参数添加后\(requestDict)")
        
        var params = requestDict.flatmapOfDict
        //将参数后面拼接上固定的编码
        params += SIGN_KEY_DEFINE
//        print("编码之前的参数：\(params)")
        let lvtuKey = params.md5
//        print("编码之后的lvtuKey：\(lvtuKey)")
        
        //将尾巴字典中的lvtukey编码出来，并赋值给"lvtukey"这个键
        requestDict["lvtukey"] = lvtuKey
//        print("最终请求字典：\(requestDict)")
        //最终的请求参数字典
        return requestDict
    }
    
    /// generateKeyDict 生成需要字节编码的字典
    ///
    /// - Parameters:
    ///   - check: 是否需要检查版本
    ///   - closure: 是否是API接口/CMS接口
    /// - Returns: 最终可以进行字节编码的字典
    private func generateKeyDict(_ check: Bool, _ closure:((_ dict: inout [String: String]) -> ())?) -> [String: String] {
        var dict:[String:String] = [:]
        if check {
            dict["checkVersion"] = "True"
        }
        if let closure = closure {//如果有闭包传入
            //证明是API借口，需要将字典拼接上"version"和"method"字段
            closure(&dict)
            print("编码需要拼接的参数：\(dict)")
        }
        //如果是CMS接口，则不用拼接字段，直接加上尾巴字典返回就可以
        dict += tailDict
        //        print("需要编码的参数字典：\(dict)")
        return dict
    }
}
