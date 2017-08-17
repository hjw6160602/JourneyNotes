//
//  JourenyDetailScenicEntity.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation
import Himotoki

struct JourenyDetailScenicEntity: Himotoki.Decodable {
    var scenicId: Int?
    /** 组ID */
    var groupId: Int?
    /** 景点名称ID */
    var scenicNameId: Int?
    /** 参考价格（单位：分） */
    var referencePrice: Int?
    /** 景点名称 */
    var scenicName: String?
    /** 简短说明 */
    var briefExplain: String?
    /** 行程已含、自费景点、推荐景点 */
    var scenicExplain: String?
    /** 币种 (CNY("人民币"), USD("美元"), CHF("法郎"), MOP("澳门币"), HKD("港币"), JPY("日元"), KRW("韩元"), AUD("澳币"), THB("泰铢"), EUR("欧元"), GBP("英镑"); */
    var currency: String?
    /** 其他服务包含提示 */
    var otherFeesTip: String?
    /** 出行类型（徒步、行驶）*/
    var travelType: String?
    /** 出行交通时间，几小时几分钟，另有全天，上午，下午等特殊值 */
    var travelTime: String?
    /** 公里数 */
    var distanceKM: Float?
    /** 游览时间，几小时几分钟，另有全天，上午，下午等特殊值 */
    var visitTime: String?
    /** 景点描述 */
    var scenicDesc: String?
    /** 是否使用话术模板 */
    var useTemplateFlag: Bool?
    /** 话术模板编号 */
    var templateCode: String?
    /** 逻辑关系（和AND、或OR） */
    var logicRelateion: String?
    /** 逻辑关系名称（和AND、或OR） */
    var logicRelateionName: String?
    /** 创建时间 */
    var createTime: String?
    /** 修改时间 */
    var updateTime: String?
    /** 话术模板文本 */
    var templateText: String?
    /** 景点图片url的List */
    var imageUrl: [String]?
    
    static func decode(_ e: Extractor) throws -> JourenyDetailScenicEntity {
        return try JourenyDetailScenicEntity (
            scenicId : e <|? "scenicId",
            groupId : e <|? "groupId",
            scenicNameId : e <|? "scenicNameId",
            referencePrice : e <|? "referencePrice",
            scenicName : e <|? "scenicName",
            briefExplain : e <|? "briefExplain",
            scenicExplain : e <|? "scenicExplain",
            currency : e <|? "currency",
            otherFeesTip : e <|? "otherFeesTip",
            travelType : e <|? "travelType",
            travelTime : e <|? "travelTime",
            distanceKM : e <|? "distanceKM",
            visitTime : e <|? "visitTime",
            scenicDesc : e <|? "scenicDesc",
            useTemplateFlag : e <|? "isUseTemplateFlag",
            templateCode : e <|? "templateCode",
            logicRelateion : e <|? "logicRelateion",
            logicRelateionName : e <|? "logicRelateionName",
            createTime : e <|? "createTime",
            updateTime : e <|? "updateTime",
            templateText : e <|? "templateText",
            imageUrl : e <||? "imageUrl"
        )
    }
}
