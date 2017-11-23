//
//  TailTool.swift
//  驴妈妈Swift
//
//  Created by 贺嘉炜 on 2016/12/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

import UIKit

// 通过登录请求获得
let oauth_token = "5450361_6e5238cf80d17ae9a883463db9c3f914"
let oauth_token_secret = "f5acb46a54f47168b26a18d146c28915"
// 关键
let oauth_consumer_secret = "c9kqb3rdcy4sj"

let real_user = "TUZXVUxNdWx0aVVzZXJTdXBwb3J0VjE6OjU0NTAzNjF8QF9AfDU0NTAzNjF8JnxmNWFjYjQ2YTU0ZjQ3MTY4YjI2YTE4ZDE0NmMyODkxNXwmfDU0NTAzNjFfNmU1MjM4Y2Y4MGQxN2FlOWE4ODM0NjNkYjljM2Y5MTQ="

let PUBLICK_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQClC9S4wdxZMkEG4n3Jib6OMeaIz1G0ynONI1fh4UbpJoJ6qq+dg4YL4TS7hJsZcoqtZBgnqay7s8RL68HdNmj09XI9B1c7Q4dV5pzxlEApx0TRYBr5qGl6SQU1+uOWb8uJVMLmxO0aPtE+Ndx0obVoDL4SQl5mn9zd6U/ZD3MtXQIDAQAB"

let appKey = "4e13f731431fe365e4000008"

struct TailTool {
    
    let tailDict:[String : String] = {
        let version = "8.0.6"
        // 经纬度
        let latitude = "31.237871"
        let longitude = "121.386779"
        let device_token = "90e68fc28d7e5eceb49215ef249724eaac4817ffa10802eef89e6d765b1994af"
        let idfa = "9E53871C-F207-4143-9D6C-B30B9359FA08"
        let idfv = "56394509-A45F-4384-AE54-3986C2E68A58"
        let open_udid = idfv
        
        // 暂时写死时间戳
        let stamp = "1509097318"
        // let stamp = String(Date().timeStamp)
        
//        "after_style"        : "default",
//        "put_style"          : "default",
        // 拼接参数尾巴
        var tailDict = [
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
            "oauth_nonce"        : "6cc1e348-334b-4587-bf58-ca81fb2c48d2",
            "oauth_timestamp"    : stamp,
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_version"      : "1.0",
            "open_udid"          : open_udid,
            "screen_height"      : "1136",
            "screen_scale"       : "2",
            "screen_width"       : "640",
            "sys_ver"            : "9.2",
            "time_offset"        : "480" ]
        if oauth_token.count > 0 {
            //登录之后会有token，未登录没有
            tailDict += ["oauth_token": oauth_token]
        }
        
        return tailDict
    }()
    
    public func requestParams(url:String, httpMethod:HTTPMethod, params paramDict:[String : String])-> [String : String]{
        // MARK: - Step 1. 构造源串
        // 0.将参数字典拿出来，然后拼接上尾巴字典，然后返回
        var requestDict = paramDict
        requestDict += tailDict
        
        // 1.排序之后的字典拼接上&符号
        let params = requestDict.flatmapOfDict
        
        // 2.将请求的url拼接上请求参数
        let requestURL = "https://mapi.mafengwo.cn/rest/app/search/MixedItem"

        // 3.再进行一次url编码
        var originalChain = httpMethod.rawValue + "&" + requestURL.urlEncoded() + "&" + params.urlEncoded()
        
        // MARK: - Step 2. 构造密钥  oauth_consumer_secret & oauth_token_secret
        // 在oauth_consumer_secret后加&
        var keyChain = appKey.urlEncoded() + "&"
        // OAuth认证一开始，不需要oauth_token_secret，置为空。
        if oauth_token_secret.count > 0 {
            keyChain += oauth_token_secret.urlEncoded()
        }
        
        originalChain = "GET&https%3A%2F%2Fmapi.mafengwo.cn%2Frest%2Fapp%2Fsearch%2FMixedItem%2F%3F&app_code%3Dcn.mafengwo.www%26app_ver%3D8.0.6%26channel_id%3DApp%20Store%26device_token%3D90e68fc28d7e5eceb49215ef249724eaac4817ffa10802eef89e6d765b1994af%26device_type%3Dios%26hardware_model%3DiPhone6%2C2%26idfa%3D9E53871C-F207-4143-9D6C-B30B9359FA08%26idfv%3D56394509-A45F-4384-AE54-3986C2E68A58%26jsondata%3D%7B%22filter%22%3A%7B%22keyword%22%3A%22%E6%B8%85%E6%B0%B4%E5%AF%BA%22%2C%22mddid%22%3A%22%22%7D%2C%22start%22%3A%220%22%7D%26mfwsdk_ver%3D20160401%26o_lat%3D31.237871%26o_lng%3D121.386779%26oauth_consumer_key%3D4%26oauth_nonce%3D6cc1e348-334b-4587-bf58-ca81fb2c48d2%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1509097318%26oauth_token%3D5450361_6e5238cf80d17ae9a883463db9c3f914%26oauth_version%3D1.0%26open_udid%3D56394509-A45F-4384-AE54-3986C2E68A58%26screen_height%3D1136%26screen_scale%3D2%26screen_width%3D640%26sys_ver%3D9.2%26time_offset%3D480%26x_auth_mode%3Dclient_auth"

        print("源串:\n\(originalChain)")
        print("密钥：\n\(keyChain)")
        // 算出SHA1加密算法之后的字节码
        let bytes = originalChain.hmac(algorithm: .SHA1, key: keyChain)
        // 摘要签名串
        let oauth_signature = bytes.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        print("摘要签名：\n\(oauth_signature)")
//      hIA1Oigg7La8owDQ%2Bu6MucBf0aI%3D
        
        //将尾巴字典中的lvtukey编码出来，并赋值给"lvtukey"这个键
        requestDict["oauth_signature"] = oauth_signature
//        print("最终请求字典：\(requestDict)")
        //最终的请求参数字典
        return requestDict
    }
}


