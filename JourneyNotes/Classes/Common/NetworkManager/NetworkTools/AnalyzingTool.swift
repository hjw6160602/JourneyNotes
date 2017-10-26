//
//  AnalyzingTool.swift
//  LvmmModel
//
//  Created by 贺嘉炜 on 2017/1/4.
//  Copyright © 2017年 Nee. All rights reserved.
//

import Foundation

struct AnalyzingTool {
    static let Directory = "RequestBundle.bundle"
    
    /// paramsFromPlist
    /// 根据传入的资源文件名称引找到请求数据字典
    /// - Parameters:
    ///   - resource: 资源文件名称
    /// - Returns: 返回需要请求的url
    // 请求方法method，请求参数params
    static func paramsFromPlist(resource:String) -> (host:String, page:String, method:String, params:[String: String]?){
        let path = Bundle.main.path(forResource: resource, ofType: "plist", inDirectory: Directory)

        let dict = NSMutableDictionary(contentsOfFile: path!)!
        let host = dict["host"] as! String
        let page = dict["page"] as! String
        let method = dict["method"] as! String
//        let version = dict["version"] as! String
    
        let originParams = dict["params"] as! [String:String]
        
        var params:[String: String]?
        // 蚂蜂窝的接口没有 version字段
//        if let version = dict["version"] {
//            params = ["version":version as! String]
//        }
        
        for (key, value) in originParams {
            let valueString = value
            let length = valueString.lengthOfBytes(using: String.Encoding.utf8)
            
            if length > 0 {
                params?[key] = value
            }
        }
        return (host, page, method, params)
    }
}
