//
//  JourneyEachDayItemView.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import UIKit

enum JourneySummaryItemStyle : Int {
    // 景点
    case scenic = 1
    // 景点
    case hotel = 2
    // 酒店
    case vehicle = 3
    // 交通
    case meal = 4
    // 餐饮
    case shopping = 5
    // 购物
    case freeActivity = 6
}

class JourneyEachDayItemView: UIView {
    convenience init(style: JourneySummaryItemStyle, itemEntity: JourenyDetailGroupEntity, frame: CGRect) {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


}
