//
//  StringExtension.swift
//  贝思客Swift
//
//  Created by SaiDicaprio on 15/12/23.
//  Copyright © 2015年 SaiDicaprio. All rights reserved.
//

import Foundation

extension String {
    /** 字符串转字典 */
    var stringToDic : [String: AnyObject]? {
        let dataWeb:Data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        var returnData:[String: AnyObject]?
        do {
            let json : Any = try JSONSerialization.jsonObject(with: dataWeb, options: JSONSerialization.ReadingOptions.mutableContainers)
            returnData = json as? [String: AnyObject]
        }  catch{
            print(error)
        }
        return returnData
    }
    
    /** 字符串转md5加密 */
//    var md5:String{
//        let cStr = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let DigestLen = Int(CC_MD5_DIGEST_LENGTH)
//        //Swift 2.3
////        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: DigestLen)
//        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: DigestLen)
//        CC_MD5(cStr!, strLen, result)
//        let hash = NSMutableString()
//        for i in 0..<DigestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deallocate(capacity: DigestLen)
//        return String(format: hash as String)
//    }
    

    /**
     将当前字符串拼接到cache目录后面
     */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    func docDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    func tmpDir() -> String
    {
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    
}
