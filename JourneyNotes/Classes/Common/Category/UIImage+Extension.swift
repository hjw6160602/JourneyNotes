//
//  NSDictionaryExtension.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 15/12/23.
//  Copyright © 2015年 SaiDicaprio. All rights reserved.
//

import UIKit
import CoreGraphics

// 在开发APP时，当前为了让APP更加美观，经常会给NavigationBar设置一个颜色，如果你直接给navigationBar设置颜色，
// 会发现根本达不到效果，呈现出来的颜色根本不是设置的颜色，这是因为系统的navigation设置的透明度的原因
// 那怎样才能达到想要的效果呢，你需要一张图片，然后设置它的图片就OK了

/**
 *  @brief  根据颜色生成纯色图片
 *  @param color 颜色
 *  @return 纯色图片
 */
extension UIImage {

    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
