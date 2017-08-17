//
//  JourenyDetailGroupEntity.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation
import Himotoki

struct JourenyDetailGroupEntity: Himotoki.Decodable {
    /** 主键ID */
    var groupId: Int?
    /** 行程ID */
    var routeId: Int?
    /** 行程明细ID */
    var detailId: Int?
    /** 产品ID，缓存用，可能为空 */
    var productId: Int?
    /** 排序值 */
    var sortValue: Int?
    /** 模块类型ID */
    var moduleType: String?
    /**本模块的开始时间，几点几分，另有全天，上午，下午等特殊值 */
    var startTime: String?
    /** 话术模板内容 */
    var hotelTemplateText: String?
    /** 是否是当地时间 */
    var localTimeFlag: String?
    /** 创建时间 */
    var createTime: String?
    /** 修改时间 */
    var updateTime: String?
    /** 景点列表 详细 */
    var prodRouteDetailScenicList: [JourenyDetailScenicEntity]?
    /** 酒店列表 详细 */
//    var prodRouteDetailHotelList: [JourenyDetailHotelEntity]?
    /** 购物点列表 详细 */
//    var prodRouteDetailShoppingList: [JourenyDetailShoppingEntity]?
    /** 用餐模块 详细 */
//    var prodRouteDetailMealList: [JourenyDetailMealEntity]?
    /** 交通模块 详细 */
    var prodRouteDetailVehicleList: [JourenyDetailVehicleEntity]?
    
    static func decode(_ e: Extractor) throws -> JourenyDetailGroupEntity {
        return try JourenyDetailGroupEntity (
            groupId : e <|? "groupId",
            routeId : e <|? "routeId",
            detailId : e <|? "detailId",
            productId : e <|? "productId",
            sortValue : e <|? "sortValue",
            moduleType : e <|? "moduleType",
            startTime : e <|? "startTime",
            hotelTemplateText : e <|? "hotelTemplateText",
            localTimeFlag : e <|? "localTimeFlag",
            createTime : e <|? "createTime",
            updateTime : e <|? "updateTime",
            prodRouteDetailScenicList : e <||? "prodRouteDetailScenicList",
//            prodRouteDetailHotelList : e <||? "prodRouteDetailHotelList",
//            prodRouteDetailShoppingList : e <||? "prodRouteDetailShoppingList",
//            prodRouteDetailMealList : e <||? "prodRouteDetailMealList",
            prodRouteDetailVehicleList : e <||? "prodRouteDetailVehicleList"
        )
    }
    
}
