//
//  CommonRequest.swift
//  驴妈妈Swift
//
//  Created by 贺嘉炜 on 2017/1/19.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

import Foundation

struct CommonRequest: Request {
    
    typealias Response = ResponseResult
    
    var page: String
    var method: String
    var httpMethod: HTTPMethod
    var parameter: [String: String] = [:]
    
    func parse(data: Data) -> ResponseResult? {
        return ResponseResult(data: data)
    }
}
