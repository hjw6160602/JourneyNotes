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


fileprivate let kIconWH: CGFloat = 18
let titleX = kIconWH + MARGIN * 2

class JourneyEachDayItemView: UIView {

    var iconImageName = ""
    var titleLabelTxt = ""
    var itemStyle: JourneySummaryItemStyle = .nothing
    var itemEntity: JourenyDetailGroupEntity?
    
    convenience init(style: JourneySummaryItemStyle, entity: JourenyDetailGroupEntity, frame: CGRect) {
        self.init(frame:frame)
        itemStyle = style
        itemEntity = entity;
        initData()
        drawDashLine()
        initUI()
    }
    
    private func initUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
    }
    
    /** 某一项具体活动的数据Entity */
    private func initData() {
        switch itemStyle {
        case .scenic:
            if let entities = itemEntity?.prodRouteDetailScenicList {
                if entities.count > 0 {
                    iconImageName = "journey_icon_scenic_18x18_"
                    titleLabelTxt = "景点："
                    deal(with: .scenic, entities: entities)
                }
            }
        case .hotel:
            if let entities = itemEntity?.prodRouteDetailHotelList {
                if entities.count > 0 {
                    iconImageName = "boss3_diy_hotel_18x18_"
                    titleLabelTxt = "住宿："
                    deal(with: .hotel, entities: entities)
                }
            }
        case .vehicle:
            if let entities = itemEntity?.prodRouteDetailVehicleList {
                if entities.count > 0 {
                    iconImageName = "icon_playDetail_bus_18x18_"
                    let text = "交通："
                    titleLabelTxt = text
                    deal(with: .vehicle, entities: entities)
                }
            }
//        case .meal:
//            if let entities = itemEntity?.prodRouteDetailMealList {
//                if entities.count > 0 {
//                    iconImageName = "book_info_19x19_"
//                    titleLabelTxt = "餐饮："
//                    deal(with: .meal, entities: entities)
//                }
//            }
        default: break
        }
    }
    
    
    // MARK : - private funcs
    /**
     * @func   dealWithStyle : 处理行程项目数组中的数据
     * @param  style    行程项目的类型
     *         entities 行程项目中的某一项有多个可选项的可选数组
     */
    func deal(with style: JourneySummaryItemStyle, entities: [Any]) {
        var currentHeight: CGFloat = 0
        //一上来是可选项的第一项
        var isFirst: Bool = true
        for entity: Any in entities {
            let itemView = JourneyOptionItemView(style: style, optionalItem: entity, isFirst: isFirst)
            //之后都不是第一项
            isFirst = false
            itemView.y = currentHeight
            addSubview(itemView)
            
            //算出当前的高度
            currentHeight += itemView.height
        }
        self.height = currentHeight
    }
    
    /** 画虚线 */
    private func drawDashLine (){
        let lineView: UIView = UIView(frame: CGRect(x: MARGIN, y: MARGIN, width: kIconWH, height: self.height))
        self.addSubview(lineView)
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = lineView.bounds
        
        shapeLayer.position = CGPoint(x: lineView.width / 2, y: lineView.height / 2)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        // 设置虚线颜色为
        shapeLayer.strokeColor = grayColor(220).cgColor
        // 设置虚线宽度
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        // 设置线宽，线间距
        shapeLayer.lineDashPattern = [NSNumber(value: 4), NSNumber(value: 2)]
        // 设置路径
        let path:CGMutablePath = CGMutablePath()
        // 设置起点
        path.move(to: CGPoint(x: kIconWH * 0.5, y: 0))
        // 设置终点
        path.addLine(to: CGPoint(x: kIconWH * 0.5, y: lineView.height ))
        shapeLayer.path = path
        // 把绘制好的虚线添加上来
        lineView.layer.addSublayer(shapeLayer)
    }
    
    // MARK: - lazy loads
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: self.iconImageName))
        imageView.frame = CGRect.init(x: MARGIN, y: MARGIN, width: kIconWH, height: kIconWH)
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        let titleW: CGFloat = SCREEN_WIDTH - titleX - MARGIN
        if self.titleLabelTxt.count > 0 {
            titleLabel.frame = CGRect(x: titleX, y: MARGIN, width: titleW, height: 20)
        }
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = self.titleLabelTxt
        titleLabel.textColor = kTextBlack
        return titleLabel
    }()
}

extension JourneyEachDayItemView {
    
}
