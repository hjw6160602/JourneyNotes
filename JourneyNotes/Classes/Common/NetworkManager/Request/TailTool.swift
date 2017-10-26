//
//  TailTool.swift
//  驴妈妈Swift
//
//  Created by 贺嘉炜 on 2016/12/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

import UIKit

struct TailTool {
    static let PUBLICK_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQClC9S4wdxZMkEG4n3Jib6OMeaIz1G0ynONI1fh4UbpJoJ6qq+dg4YL4TS7hJsZcoqtZBgnqay7s8RL68HdNmj09XI9B1c7Q4dV5pzxlEApx0TRYBr5qGl6SQU1+uOWb8uJVMLmxO0aPtE+Ndx0obVoDL4SQl5mn9zd6U/ZD3MtXQIDAQAB"
    static let rcAppKey = "c9kqb3rdcy4sj"
    
    let tailDict:[String : String] = {
        //蚂蜂窝接口请求不传这个参数，获取当前网络类型
//        let networkType =  (Utils.mobileNetworkCode().characters.count > 0) ? Utils.mobileNetworkCode() : "WIFI"
        
        // 这里直接传 蚂蜂窝的 固定版本号
//        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let version = "8.0.6"
        // 经纬度
        let latitude = "31.237887"
        let longitude = "121.386825"
        let device_token = "90e68fc28d7e5eceb49215ef249724eaac4817ffa10802eef89e6d765b1994af"
        let idfa = "9E53871C-F207-4143-9D6C-B30B9359FA08"
        let idfv = "56394509-A45F-4384-AE54-3986C2E68A58"
        let open_udid = idfv
        
        // 暂时写死时间戳
        let stamp = "1508923282"
        // let stamp = String(Date().timeStamp)
        
//        "after_style"        : "default",
//        "put_style"          : "default",
        // 拼接参数尾巴
        let tailDict = [
            "app_code"           : "cn.mafengwo.www",
            "app_ver"            : version,
            "channel_id"         : "App Store",
            "device_token"       : device_token,
            "device_type"        : "ios",
            "hardware_model"     : "iPhone6,2",
            "idfa"               : idfa,
            "idfv"               : idfv,
            "mfwsdk_ver"         : "20160401",
            "o_lat"              : latitude,
            "o_lng"              : longitude,
            "oauth_consumer_key" : "4",
            "oauth_nonce"        : "5cd35700-a835-435b-8b7f-af1b670f49ed",
            "oauth_timestamp"    : stamp,
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_token"        : "5450361_6e5238cf80d17ae9a883463db9c3f914",
            
            "oauth_version"      : "1.0",
            "open_udid"          : open_udid,
            "screen_height"      : "1136",
            "screen_scale"       : "2",
            "screen_width"       : "640",
            "sys_ver"            : "9.2",
            "time_offset"        : "480" ]
        
//        "oauth_signature"  : "1/pLM9AnTKsliccPZ+hkkhXN9Nk"  : "",
        
        return tailDict
    }()
    
    public func requestParams(paramDict:[String : String])-> [String : String]{
        //将参数字典拿出来，然后拼接上尾巴字典，然后返回
        var requestDict = paramDict
//        print(requestDict)
        requestDict += tailDict
        
        // 排序之后的字典拼接上&符号
        let params = requestDict.flatmapOfDict
        
        //将参数后面拼接上固定的编码
        print("编码之前的参数：\n",params)

        let bytes = params.hmac(algorithm: .SHA1, key: TailTool.PUBLICK_KEY)
        let oauth_signature = bytes.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
//        print("编码之后的lvtuKey：\(lvtuKey)")
        
        //将尾巴字典中的lvtukey编码出来，并赋值给"lvtukey"这个键
        requestDict["oauth_signature"] = oauth_signature
//        print("最终请求字典：\(requestDict)")
        //最终的请求参数字典
        return requestDict
    }
}
