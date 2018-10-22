//
//  UILabel+Extension.swift
//  驴妈妈Swift
//
//  Created by SaiDicaprio on 2017/1/18.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit
//import Foundation
import CoreGraphics


extension UILabel{
    //计算label的宽度和高度
    var textSize: CGSize{
        if let text = text {
            var size = CGRect();
            //计算label的字体
            let size2 = CGSize(width: 0, height: 0);//设置label的最大宽度
            size = (text.boundingRect(with: size2, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!] , context: nil));
            return size.size
        } else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    var textWidth: CGFloat{
        return textSize.width
    }
    
    var textHeight: CGFloat{
        return textSize.height
    }
}
