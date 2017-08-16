//
//  JourenyDetailGroupEntity.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation

struct JourenyDetailGroupEntity {
    /** 主键ID */
    var groupId: Int = 0
    /** 行程ID */
    var routeId: Int = 0
    /** 行程明细ID */
    var detailId: Int = 0
    /** 产品ID，缓存用，可能为空 */
    var productId: Int = 0
    /** 排序值 */
    var sortValue: Int = 0
    /** 模块类型ID */
    var moduleType: String = ""
    /**本模块的开始时间，几点几分，另有全天，上午，下午等特殊值 */
    var startTime: String = ""
    /** 话术模板内容 */
    var hotelTemplateText: String = ""
    /** 是否是当地时间 */
    var localTimeFlag: String = ""
    /** 创建时间 */
    var createTime: String = ""
    /** 修改时间 */
    var updateTime: String = ""
    /** 景点列表 详细 */
    var prodRouteDetailScenicList = [JourenyDetailScenicEntity]()
    /** 酒店列表 详细 */
    var prodRouteDetailHotelList = [JourenyDetailHotelEntity]()
    /** 购物点列表 详细 */
    var prodRouteDetailShoppingList = [JourenyDetailShoppingEntity]()
    /** 用餐模块 详细 */
    var prodRouteDetailMealList = [JourenyDetailMealEntity]()
    /** 交通模块 详细 */
    var prodRouteDetailVehicleList = [JourenyDetailVehicleEntity]()
}
