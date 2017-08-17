//
//  ProdLineRouteDetail.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation
import Himotoki

struct ProdLineRouteDetail: Himotoki.Decodable {
    // 明细id
    var detailId: Int64 = 0
    //第几天
    var nDay: Int16 = 0
    //行程内容
    var content: String = ""
    //早餐描述
    var breakfastDesc: String = ""
    //是否有早餐
    var isBreakfastFlag: Bool = false
    //晚餐描述
    var dinnerDesc: String = ""
    //是否有晚餐
    var isDinnerFlag: Bool = false
    //午餐描述
    var lunchDesc: String = ""
    //是否有午餐
    var isLunchFlag: Bool = false
    // 关联行程ID
    var routeId: Int64 = 0
    //住宿描述
    var stayDesc: String = ""
    //住宿类型
    var stayType: String = ""
    //标题
    var title: String = ""
    //其他交通
    var trafficOther: String = ""
    //交通工具类型
    var trafficType: String = ""
    //交通工具类型中文
    var trafficTypeZh: String = ""
    //图片
    var imageList = [String]()
    // 线路明细组列表（结构化用）
//    var generalGroupMap = [String: Any]()
    
    /** 7.9.7 汪雨璐 新增 详细行程概要 */
    var prodRouteDetailGroupList = [JourenyDetailGroupEntity]()
    
    // MARK: Himotoki.Decodable
    
//    static func decode(_ e: Extractor) throws -> ProdLineRouteDetail {
//        return try ProdLineRouteDetail(
//            name: e <| "name",
//            floor: e <| "floor",
//            locationName: e <| [ "location", "name" ], 
//            optional: e <||? "optional"
//        )
//    }
    
    static func decode(_ e: Extractor) throws -> ProdLineRouteDetail {
        return try ProdLineRouteDetail (
            detailId : e <| "detailId",
            nDay : e <| "nDay",
            content : e <| "content",
            breakfastDesc : e <| "breakfastDesc",
            isBreakfastFlag : e <| "isBreakfastFlag",
            dinnerDesc : e <| "dinnerDesc",
            isDinnerFlag : e <| "isDinnerFlag",
            lunchDesc : e <| "lunchDesc",
            isLunchFlag : e <| "isLunchFlag",
            routeId : e <| "routeId",
            stayDesc : e <| "stayDesc",
            stayType : e <| "stayType",
            title : e <| "title",
            trafficOther : e <| "trafficOther",
            trafficType : e <| "trafficType",
            trafficTypeZh : e <| "trafficTypeZh",
            imageList : e <|| "imageList",
//            generalGroupMap : e <|-| "generalGroupMap",
            prodRouteDetailGroupList : e <|| "prodRouteDetailGroupList"
        )
    }
}
