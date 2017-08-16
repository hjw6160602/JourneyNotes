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

class JourneyEachDayItemView: UIView {
    
    /** 某一项具体活动的数据Entity */
    var itemEntity: JourenyDetailGroupEntity = JourenyDetailGroupEntity()
    
    convenience init(style: JourneySummaryItemStyle, itemEntity: JourenyDetailGroupEntity, frame: CGRect) {
        self.init(frame:frame)
        self.itemEntity = itemEntity;
        initUI()
    }
    
    private func initUI() {
        
    }
    
}


extension JourneyEachDayItemView {
    
}
