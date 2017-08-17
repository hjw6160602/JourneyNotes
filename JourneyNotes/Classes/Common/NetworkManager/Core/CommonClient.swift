//
//  CommonClient.swift
//  驴妈妈Swift
//
//  Created by 贺嘉炜 on 2017/1/19.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

import Foundation

/** URLSession 配置 */
private let session: URLSession = {
    
    let cfg = URLSessionConfiguration.default
    cfg.timeoutIntervalForRequest = 20
    // 是否允许使用蜂窝网络（手机自带网络）
    cfg.allowsCellularAccess = true
    return URLSession(configuration: cfg)
    
}()

struct CommonClient: Client {
    var host: String
    
    /// send 遵守客户端协议，发送请求
    ///
    /// - Parameters:
    ///   - r: 传入一个请求对象泛型
    ///   - handler: 一个用于处理 返回数据 的闭包
    func send<T : Request>(_ r: T, handler: @escaping (T.Response?) -> Void) {
        if var request = generateURLRequest(r) { // 发送请求
            request.httpMethod = r.httpMethod.rawValue
            let task = session.dataTask(with: request) {
                data, _, error in
                if let data = data, let res = T.Response.parse(data: data) {
                    DispatchQueue.main.async { handler(res) }
                } else {
                    DispatchQueue.main.async { handler(nil) }
                }
            }
            task.resume()
        }
    }
    
    private func generateURLRequest<T : Request>(_ r: T) -> URLRequest?{
        var params = r.parameter
        
//        var closure:((inout [String :String]) -> ())?
        
        //最初的url字符串等于其host+请求的page页
        var urlString = host + r.page
//
//        if r.method.hasPrefix("/") {//如果是CMS请求
//            urlString = urlString + r.method + "&"
//            closure = nil
//        } else{
//            closure = { (dict) in
//                dict["method"] = r.method
//            }
//        }
    
        //将参数尾巴拼接上去（CMS接口的拼接方法和API请求方法的拼接方式不一样，用闭包是否为空来判断）
//        params = TailTool().requestParams(paramDict: params, check: false, closure)
        
        //如果为POST请求，那么将[请求参数]从[尾巴参数字典]中移除
        if r.httpMethod == .POST {
            for (key, _) in r.parameter {
                if key != "version" {
                    params.removeValue(forKey: key)
                }
            }
        }
        
        //将参数字典展开成为字符串
        let finalParams = params.flatmapOfDict
        
        //将展平的参数拼接到url字符串上面去
        urlString += finalParams
        
        print("最终的请求URL：\n\(urlString)")
        
        var request:URLRequest?
        if let URL = URL(string: urlString){
            request = URLRequest(url: URL)
        }
        
        //如果为POST请求，那么将参数字符串拼接后的结果转为Data传给httpBody
        if r.httpMethod == .POST {
            var parameter = r.parameter
            parameter.removeValue(forKey: "version")
            print("请求方法为POST请求参数为：\(parameter)")
            request?.httpBody = parameter.flatmapOfDict.data(using: .utf8)
        }
        
        return request
    }
}
