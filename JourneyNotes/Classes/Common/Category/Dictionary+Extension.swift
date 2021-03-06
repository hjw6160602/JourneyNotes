//
//  NSDictionaryExtension.swift
//  贝思客Swift
//
//  Created by SaiDicaprio on 15/12/23.
//  Copyright © 2015年 SaiDicaprio. All rights reserved.
//

import Foundation

extension Dictionary {
    /** 可变字典转json */
    var json:String{
        var json = ""
        do{
            let data = try JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            json = String(data: data, encoding: String.Encoding.utf8)!
        }
        catch{
            print(error)
        }
        return json
    }
    
    var flatmapOfDict: String{
        var params = ""
        if self.count == 0{
            return params
        }
        //字典排序
        let sortedDict = self.sorted {
            return ($0.key as! String) < ($1.key as! String)
        }
        var index = 1
        for (key, value) in sortedDict {
            let keyString = key as! String
            //如果key不为空，再去拼接
            if keyString.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                params += "\(key)=\(value)"
                if index < sortedDict.count {
                    params += "&"
                }
            }
            index += 1
        }
        return params
    }
}

extension NSMutableDictionary {
    /** 可变字典转json */
    var json:String{
        var json = ""
        do{
            let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            json = String(data: data, encoding: String.Encoding.utf8)!
        }
        catch{
            print(error)
        }
        return json
    }
}
