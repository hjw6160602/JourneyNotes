//
//  JourneyOptionItemView.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

fileprivate let LineSpaceMargin: CGFloat = 4

class JourneyOptionItemView: UIView {

    var titleLabelTxt = ""
    var briefLabelTxt = ""
    var contentLabelTxt = ""

    /** 某一项具体活动的数据Entity */
    var optionalItem: Any?
    /** 行程概要 景点 详细数据Entity */
    var scenicEntity: JourenyDetailScenicEntity?
    /** 行程概要 景点 详细数据Entity */
    var hotelEntity: JourenyDetailHotelEntity?
    /** 行程概要 景点 详细数据Entity */
    var vehicleEntity: JourenyDetailVehicleEntity?
    /** 行程概要 景点 详细数据Entity */
    var mealEntity: JourenyDetailMealEntity?
    /** 行程概要 景点 详细数据Entity */
    var shoppingEntity: JourenyDetailShoppingEntity?
    /** 某一项具体活动的活动类型 */
    var style: JourneySummaryItemStyle = .nothing
    
    convenience init(style: JourneySummaryItemStyle, optionalItem: Any,  isFirst: Bool) {
        self.init(frame: CGRect.zero)
        self.style = style
        self.optionalItem = optionalItem
        initUI()
//        layoutSubviewsGetHeight()
    }
    
    private func initUI() {
        if titleLabelTxt.characters.count > 0 {
            addSubview(titleLabel)
        }
        if briefLabelTxt.characters.count > 0 {
            addSubview(briefLabel)
        }
        if contentLabelTxt.characters.count > 0 {
            addSubview(contentLabel)
        }
        //        if summayImageView {
        //            addSubview(summayImageView)
        //        }
    }
    
    /** 标题Label */
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.briefLabelTxt
        label.textColor = kGlobalPink
        return label
    }()
    
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
