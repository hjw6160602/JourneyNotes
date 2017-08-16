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
