//
//  UIColor+Extension.swift
//  驴妈妈Swift
//
//  Created by 贺嘉炜 on 2016/12/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    // MARK: - 功能性函数
    static func rgb (_ R:Int, _ G:Int, _ B:Int) -> UIColor{
        let red   :CGFloat = CGFloat(R)/255.0
        let green :CGFloat = CGFloat(G)/255.0
        let blue  :CGFloat = CGFloat(B)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func globle() -> UIColor{
        return self.rgb(233, 38, 141)
    }
    
    static func random() -> UIColor{
        return self.rgb(Int(arc4random_uniform(256)), Int(arc4random_uniform(256)), Int(arc4random_uniform(256)))
    }
}
