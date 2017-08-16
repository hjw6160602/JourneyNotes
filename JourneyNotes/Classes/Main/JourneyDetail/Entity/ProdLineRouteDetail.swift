//
//  ProdLineRouteDetail.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation

struct ProdLineRouteDetail {
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
    var imageList = [Any]()
    // 线路明细组列表（结构化用）
    var generalGroupMap = [AnyHashable: Any]()
    
    /** 7.9.7 汪雨璐 新增 详细行程概要 */
    var prodRouteDetailGroupList = [JourenyDetailGroupEntity]()
}
