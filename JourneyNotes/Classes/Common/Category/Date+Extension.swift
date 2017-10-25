//
//  Date+Extension.swift
//  驴妈妈Swift
//
//  Created by 贺嘉炜 on 2016/12/23.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

import Foundation

/**
 *  @description 当前时间距1970的时间戳，精确到秒
 *  @return long 返回当前时间距1970的时间戳，精确到秒
 */
public extension Date {
    var timeStamp:UInt64{
        return UInt64(self.timeIntervalSince1970)
    }
}
