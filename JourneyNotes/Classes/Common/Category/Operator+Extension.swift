//
//  Operator+Extension.swift
//  驴妈妈Swift
//
//  Created by 贺嘉炜 on 2016/12/28.
//  Copyright © 2016年 贺嘉炜. All rights reserved.
//

import Foundation
/** 在NSMutableDictionary中，如果要添加一整个Dictionary可以使用方法：
 *  - (void)addEntriesFromDictionary:(NSDictionary<KeyType,ObjectType> *)otherDictionary
 *  但是在swift中，并没有类似的方法，只能一次设置一个值：
 *  mutating func updateValue(value: Value, forKey key: Key) -> Value?
 */

func += <KeyType, ValueType> ( left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
