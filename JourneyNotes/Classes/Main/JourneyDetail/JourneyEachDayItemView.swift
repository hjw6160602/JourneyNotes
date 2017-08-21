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
    // default
    case nothing = ""
}

fileprivate let MARGIN_H: CGFloat = 5
fileprivate let MIN_HEIGHT: CGFloat = 16
fileprivate let titleX = MIN_HEIGHT + MARGIN * 2

class JourneyEachDayItemView: UIView {

    var iconImageName = "book_info_19x19_"
    var titleLabelTxt = ""
    var itemStyle: JourneySummaryItemStyle = .nothing
    var itemEntity: JourenyDetailGroupEntity?
    
    convenience init(style: JourneySummaryItemStyle, entity: JourenyDetailGroupEntity, frame: CGRect) {
        self.init(frame:frame)
        itemStyle = style
        itemEntity = entity;
        initData()
        initUI()
        layoutSubviewsGetHeight()
    }
    
    private func initUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
    }
    
    private func layoutSubviewsGetHeight (){
        var currentHeight: CGFloat = 0
        let titleW: CGFloat = SCREEN_WIDTH - titleX - MARGIN
        if titleLabelTxt.characters.count > 0 {
            let titleH: CGFloat = 20
            let titleY: CGFloat = currentHeight + MARGIN
            titleLabel.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            currentHeight += titleH + MARGIN_H
        }
    }
    
    /** 某一项具体活动的数据Entity */
    private func initData() {
        switch itemStyle {
        case .scenic:
            if let entities = itemEntity?.prodRouteDetailScenicList {
                if entities.count > 0 {
                    iconImageName = "book_info_19x19_"
                    titleLabelTxt = "景点"
                    deal(with: .scenic, entities: entities)
                }
            }
        case .hotel:
            if let entities = itemEntity?.prodRouteDetailHotelList {
                if entities.count > 0 {
                    iconImageName = "book_info_19x19_"
                    titleLabelTxt = "住宿"
                    deal(with: .hotel, entities: entities)
                }
            }
        case .vehicle:
            if let entities = itemEntity?.prodRouteDetailVehicleList {
                if entities.count > 0 {
                    iconImageName = "book_info_19x19_"
                    let vehicleEntity: JourenyDetailVehicleEntity? = entities.first
                    var text = "交通："
                    if let vehicleName = vehicleEntity?.vehicleName {
                        text += vehicleName
                    }
                    titleLabelTxt = text
                    deal(with: .vehicle, entities: entities)
                }
            }
        case .meal:
            if let entities = itemEntity?.prodRouteDetailMealList {
                if entities.count > 0 {
                    iconImageName = "book_info_19x19_"
                    titleLabelTxt = "餐饮"
                    deal(with: .meal, entities: entities)
                }
            }
        case .shopping:
            if let entities = itemEntity?.prodRouteDetailShoppingList {
                if entities.count > 0 {
                    iconImageName = "book_info_19x19_"
                    titleLabelTxt = "购物"
                    deal(with: .shopping, entities: entities)
                }
            }
        default: break
        }
    }
    
    /**
     * @func   dealWithStyle : 处理行程项目数组中的数据
     * @param  style    行程项目的类型
     *         entities 行程项目中的某一项有多个可选项的可选数组
     */
    func deal(with style: JourneySummaryItemStyle, entities: [Any]) {
        var currentHeight: CGFloat = titleLabel.height
        //一上来是可选项的第一项
        var isFirst: Bool = true
        for entity: Any in entities {
            let itemView = JourneyOptionItemView(style: style, optionalItem: entity, isFirst: isFirst)
            //之后都不是第一项
            isFirst = false
            itemView.y = currentHeight
            addSubview(itemView)
            
            itemView.height = 50
            itemView.backgroundColor = UIColor.blue
            
            //算出当前的高度
            currentHeight += itemView.height
        }
        self.height = currentHeight
    }
    
    // MARK: - lazy loads
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: self.iconImageName))
        imageView.frame = CGRect.init(x: MARGIN, y: MARGIN, width: MIN_HEIGHT, height: MIN_HEIGHT)
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = self.titleLabelTxt
        titleLabel.textColor = kGlobalPink
        return titleLabel
    }()
}

extension JourneyEachDayItemView {
    
}
