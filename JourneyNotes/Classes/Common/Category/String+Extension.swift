//
//  StringExtension.swift
//  贝思客Swift
//
//  Created by SaiDicaprio on 15/12/23.
//  Copyright © 2015年 SaiDicaprio. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 获取沙盒路径和字典操作的 extension
extension String {
    /** 字符串转字典 */
    var stringToDic : [String: AnyObject]? {
        let dataWeb:Data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        var returnData:[String: AnyObject]?
        do {
            let json : Any = try JSONSerialization.jsonObject(with: dataWeb, options: .mutableContainers)
            returnData = json as? [String: AnyObject]
        }  catch{
            print(error)
        }
        return returnData
    }
    
    /** 将当前字符串拼接到cache目录后面 */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /** 将当前字符串拼接到doc目录后面  */
    func docDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /** 将当前字符串拼接到tmp目录后面  */
    func tmpDir() -> String
    {
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /** 根据字体大小和 最大宽度算出 高度 */
    func height(with font: UIFont, maxW: CGFloat) -> CGFloat {
        var attrs = [NSAttributedStringKey: Any]()
        attrs[NSAttributedStringKey.font] = font
        
        let maxSize = CGSize(width: maxW, height: CGFloat(MAXFLOAT))
        let nsString: NSString = self as NSString
        let height = nsString.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size.height
        return height
    }

}


// 字符串加密算法
enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

// MARK: - 加密方式的 extension
extension String {
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        
        let digest = stringFromResult(result: result, length: digestLen)
        
        result.deallocate(capacity: digestLen)
        
        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    
    /** 字符串转md5加密 */
    var md5:String{
        let cStr = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let DigestLen = Int(CC_MD5_DIGEST_LENGTH)
        //Swift 2.3
//        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: DigestLen)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: DigestLen)
        CC_MD5(cStr!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<DigestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate(capacity: DigestLen)
        return String(format: hash as String)
    }
}

// MARK: - 去空格和空行操作的extension
extension String {
    /** 去掉首尾空格 */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    
    /** 去掉首尾空格 包括后面的换行 \n */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    
    /** 去掉所有空格 */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    /** 去掉所有换行 */
    var removeAllNewlines: String {
        return self.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
    }
    
    /**去掉首尾空格 后 指定开头空格数 */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
}
