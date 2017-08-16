//
//  Const.swift
//  学龄宝Swift
//
//  Created by SaiDicaprio on 15/9/23.
//  Copyright © 2015年 SaiDicaprio. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 功能性函数
//随机色
let randomColor = rgbColor(Int(arc4random_uniform(256)), Int(arc4random_uniform(256)), Int(arc4random_uniform(256)))

func rgbColor(_ R:Int, _ G:Int, _ B:Int) -> UIColor{
    let red   :CGFloat = CGFloat(R)/255.0
    let green :CGFloat = CGFloat(G)/255.0
    let blue  :CGFloat = CGFloat(B)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}

func grayColor (_ Value:Int) -> UIColor{
    return rgbColor(Value, Value, Value)
}

// MARK: - 全局需要的简写宏
/** 屏幕宽高 */
let SCREEN_FRAME  = UIScreen.main.bounds
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH  = UIScreen.main.bounds.width

let INCH3_0       = (SCREEN_WIDTH == 320) && (SCREEN_HEIGHT == 480)
let INCH4_0       = (SCREEN_WIDTH == 320) && (SCREEN_HEIGHT == 568)
let INCH4_7       = (SCREEN_WIDTH == 375) && (SCREEN_HEIGHT == 667)
let INCH5_5       = (SCREEN_WIDTH == 414) && (SCREEN_HEIGHT == 736)

let kNaviBarH: CGFloat     = 64
let kTabBarH : CGFloat     = 49
let kStatusBarH: CGFloat   = 20
let MARGIN: CGFloat        = 8

/** 全局单例 [NSUserDefaults standardUserDefaults] */
let USER_DEFAULT  = UserDefaults.standard
/** 通知中心 */
let NOTI_CENTER   = NotificationCenter.default
/** KeyWindow [UIApplication sharedApplication].keyWindow */
let KEY_WINDOW    = UIApplication.shared.keyWindow
/** 沙盒缓存路径 */
let DOC_PATH      = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
/** 手机的UUID */
let iPhone_UUID   = UIDevice.current.identifierForVendor?.uuidString
/** 主Bundle */
let MAIN_BUNDLE   = Bundle.main


