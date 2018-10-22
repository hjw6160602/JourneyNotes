//
//  ResponseResult.swift
//  驴妈妈Swift
//
//  Created by SaiDicaprio on 2016/12/22.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

import Foundation

struct ResponseResult {
    let code: String
    let message: String
    let errorMessage: String
    let version: String
    let data: Any?
    
    init?(data: Data) {
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            return nil
        }
        
        func valueForKey(obj: [String: Any]?, param: String) -> String {
            if let value = obj?[param] {
                return value as! String
            } else{
                return ""
            }
        }
        self.code = valueForKey(obj: dict, param: "code")
        self.errorMessage = valueForKey(obj: dict, param: "errorMessage")
        self.message = valueForKey(obj: dict, param: "message")
        self.version = valueForKey(obj: dict, param: "version")

        //有的接口返回的数据不再data字段里，而在datas字段里 这里默认取data字段
        var data: Any? = dict?["data"]
        
        if data == nil {//如果data字段为空，去取datas字段里的数据
            data = dict?["datas"]
        }
        
        self.data = data
    }
}

extension ResponseResult: DecodableX {
    static func parse(data: Data) -> ResponseResult? {
        return ResponseResult(data: data)
    }
}
