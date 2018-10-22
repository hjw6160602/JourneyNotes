//
//  Request.swift
//  LvmmModel
//
//  Created by SaiDicaprio on 2017/1/4.
//  Copyright © 2017年 Nee. All rights reserved.
//


struct NetworkManager {
    
    typealias ResponseClosure = (_ res:ResponseResult) -> Void
    
    static func get(api: String, params:inout [String: String], finished: @escaping ResponseClosure) {
        NetworkManager.request(method: api, httpMethod: .GET, params: &params, finished: finished);
    }
    
    static func post(api: String, params:inout [String: String], finished: @escaping ResponseClosure) {
        NetworkManager.request(method: api, httpMethod: .POST, params: &params, finished: finished);
    }
    
    /// request
    ///
    /// - Parameters:
    ///   - api: 请求接口的method
    ///   - finished: 请求完成之后的闭包
    static func request(method: String, httpMethod:HTTPMethod, params:inout [String: String], finished: @escaping ResponseClosure)  {
        //利用生成器生成请求需要的部分
        let (host, page, method, param) = AnalyzingTool.paramsFromPlist(resource: method)
        
        //如果从资源文件中取出了参数字段
        if let param = param {
            params += param
        }
        let r = CommonRequest(page: page, method:method, httpMethod: httpMethod, parameter:params)
        
        CommonClient(host: host).send(r) { (res) in
            if let res = res {
                finished(res)
            }
        }
    }
}
