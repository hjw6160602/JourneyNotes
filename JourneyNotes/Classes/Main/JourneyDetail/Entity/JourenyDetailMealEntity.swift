//
//  JourenyDetailMealEntity.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation
import Himotoki

struct JourenyDetailMealEntity: Himotoki.Decodable {
    /** 主键ID */
    var mealId: Int = 0
    /** 组ID */
    var groupId: Int = 0
    /** 参考价格，以分存储 */
    var price: Int = 0
    /** 货币单位 CNY("人民币"), USD("美元"), CHF("法郎"), MOP("澳门币"), HKD("港币"), JPY("日元"), KRW("韩元"), AUD("澳币"), THB("泰铢"), EUR("欧元"), GBP("英镑") */
    var currency: String = ""
    /** 早餐，中餐，晚餐标示 */
    var mealType: String = ""
    /** 早餐，中餐，晚餐Name */
    var mealName: String = ""
    /** 用餐描述 */
    var mealDesc: String = ""
    /** 用餐时间，xxx小时xx分钟格式 */
    var mealTime: String = ""
    /** 用餐地点，1标示酒店内，2其他 */
    var mealPlace: String = ""
    /** 用餐地点为其他时的说明信息 */
    var mealPlaceOther: String = ""
    /** 是否使用话术模板 */
    var isUseTemplateFlag: Bool = false
    /** 创建时间 */
    var createTime: String = ""
    /** 修改时间 */
    var updateTime: String = ""
    /** 话术模板文本 */
    var templateText: String = ""
    
    static func decode(_ e: Extractor) throws -> JourenyDetailMealEntity {
        return try JourenyDetailMealEntity (
            mealId : e <| "mealId",
            groupId : e <| "groupId",
            price : e <| "price",
            currency : e <| "currency",
            mealType : e <| "mealType",
            mealName : e <| "mealName",
            mealDesc : e <| "mealDesc",
            mealTime : e <| "mealTime",
            mealPlace : e <| "mealPlace",
            mealPlaceOther : e <| "mealPlaceOther",
            isUseTemplateFlag : e <| "isUseTemplateFlag",
            createTime : e <| "createTime",
            updateTime : e <| "updateTime",
            templateText : e <| "templateText"
        )
    }
}
