//
//  JourneyEachDayItemView.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

enum JourneySummaryItemStyle : String {
    // 景点
    case scenic = "SCENIC"
    // 景点
    case hotel = "HOTEL"
    // 交通
    case vehicle = "VEHICLE"
    // 餐饮
    case meal = "MEAL"
    // 购物
    case shopping = "SHOPPING"
}

fileprivate let LineSpaceMargin: CGFloat = 4

class JourneyEachDayItemView: UIView {
    
    var briefLabelTxt = ""
    var contentLabelTxt = ""
    
    /** 某一项具体活动的数据Entity */
    var itemEntity: JourenyDetailGroupEntity = JourenyDetailGroupEntity()
    
    convenience init(style: JourneySummaryItemStyle, itemEntity: JourenyDetailGroupEntity, frame: CGRect) {
        self.init(frame:frame)
        self.itemEntity = itemEntity;
        initUI()
    }
    
    private func initUI() {
        
    }
    
    /** 标题Label */
    lazy var briefLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.briefLabelTxt
        label.textColor = UIColor.darkGray
        return label
    }()
    
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.contentLabelTxt
        label.textColor = UIColor.darkGray
        // 静态显示textView的内容为设置的行间距
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = LineSpaceMargin
        // 字体的行间距
        var textViewAttributes: [AnyHashable: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSParagraphStyleAttributeName: paragraphStyle]
        var attributeContent = NSMutableAttributedString(string: self.contentLabelTxt, attributes: textViewAttributes as? [String : Any] ?? [String : Any]())
        label.attributedText = attributeContent
        return label
    }()
}


extension JourneyEachDayItemView {
    
}
