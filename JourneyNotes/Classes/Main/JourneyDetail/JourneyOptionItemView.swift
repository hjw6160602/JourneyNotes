//
//  JourneyOptionItemView.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//  一个OptionItemView代表一个项目中的可选项目

import UIKit

fileprivate let LineSpaceMargin: CGFloat = 4
fileprivate let MARGIN_H: CGFloat = 5

class JourneyOptionItemView: UIView {

    // MARK: - 成员变量
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
    /** 详情图片展示View */
    var summayImageView: JourneySummaryImageView?
    
    // MARK: - 便捷构造方法
    convenience init(style: JourneySummaryItemStyle, optionalItem: Any,  isFirst: Bool) {
        self.init(frame: CGRect.zero)
        self.style = style
        self.optionalItem = optionalItem
        initData()
        initUI()
        layoutSubviewsGetHeight()
    }
    
    
    // MARK: - 处理各种类型的数据
    private func initData() {
        switch style {
        case .scenic:
            let scenicEntity = optionalItem as! JourenyDetailScenicEntity
            dealScenic(with: scenicEntity)
        case .hotel:
            let hotelEntity = optionalItem as! JourenyDetailHotelEntity
            dealHotel(with: hotelEntity)
        case .vehicle:
            let vehicleEntity = optionalItem as! JourenyDetailVehicleEntity
            dealVehicle(with: vehicleEntity)
        default:
            break
        }
    }
    
    /** 景点 */
    private func dealScenic(with scenicVo: JourenyDetailScenicEntity) {
        scenicEntity = scenicVo
        if let scenicName = scenicEntity?.scenicName {
            titleLabelTxt = scenicName
        }
        //详细描述
        if let content = scenicEntity?.scenicDesc {
            contentLabelTxt = content
        }
        if let urls = scenicVo.imageUrl {
            print("666")
            summayImageView = JourneySummaryImageView(urls: urls, name: titleLabelTxt)
        }
    }
    
    /** 酒店 */
    private func dealHotel(with hotelVo: JourenyDetailHotelEntity) {
        hotelEntity = hotelVo
        if let hotelName = hotelEntity?.hotelName {
            titleLabelTxt = hotelName
        }
        //详细描述
        if let content = hotelEntity?.hotelDesc {
            contentLabelTxt = content
        }
        if let urls = hotelVo.imageUrl {
            print("666")
            summayImageView = JourneySummaryImageView(urls: urls, name: titleLabelTxt)
        }
    }
    
    /** 交通 */
    private func dealVehicle(with vehicleVo: JourenyDetailVehicleEntity) {
        vehicleEntity = vehicleVo
        if let vehicleName = vehicleEntity?.vehicleName {
            titleLabelTxt = vehicleName
        }
        //详细描述
        if let content = vehicleEntity?.vehicleDesc {
            contentLabelTxt = content
        }
        if let urls = vehicleVo.imageUrl {
            print("666")
            summayImageView = JourneySummaryImageView(urls: urls, name: titleLabelTxt)
        }
    }
    
    // MARK: - 处理UI
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
        if let imageView = summayImageView {
            addSubview(imageView)
        }
    }
    
    private func layoutSubviewsGetHeight() {
        var currentHeight: CGFloat = 0
        let labelH: CGFloat = 20
        let titleW: CGFloat = SCREEN_WIDTH - titleX - MARGIN - 50
        if titleLabelTxt.characters.count > 0 {
            let titleY: CGFloat = currentHeight + 10
            titleLabel.frame = CGRect(x: titleX + 50, y: titleY, width: titleW, height: labelH)
            currentHeight += labelH + MARGIN_H
        }
        if briefLabelTxt.characters.count > 0 {
            let briefY: CGFloat = currentHeight + MARGIN
            briefLabel.frame = CGRect(x: titleX, y: briefY, width: titleW, height: labelH)
            currentHeight += labelH + MARGIN_H
        }
        if contentLabelTxt.characters.count > 0 {
            let contentY: CGFloat = currentHeight + MARGIN
            contentLabel.frame = CGRect(x: titleX, y: contentY, width: titleW, height: labelH)
            currentHeight += labelH + MARGIN_H
        }
        frame = CGRect(x: 0, y: 0, width: titleW, height: currentHeight + MARGIN_H)
    }
    
    
    // MARK: -  懒加载
    /** 标题Label */
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = self.titleLabelTxt
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
