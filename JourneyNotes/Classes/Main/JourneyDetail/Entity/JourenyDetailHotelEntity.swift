//
//  JourenyDetailHotelEntity.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation
import Himotoki

struct JourenyDetailHotelEntity: Himotoki.Decodable {
    // MARK: - 共有的属性
    /** 组ID */
    var groupId: Int?
    /** 公里数 */
    var distanceKM: Float?
    /** 出行类型（徒步、行驶）*/
    var travelType: String?
    /** 出行交通时间，几小时几分钟，另有全天，上午，下午等特殊值 */
    var travelTime: String?
    /** 是否使用话术模板 */
    var useTemplateFlag: String?
    /** 话术模板编号 */
    var templateCode: String?
    /** 话术模板文案 */
    var templateText: String?
    /** 逻辑关系（和AND、或OR） */
    var logicRelateion: String?
    /** 逻辑关系名称（和AND、或OR） */
    var logicRelateionName: String?
    /** 创建时间 */
    var createTime: String?
    /** 修改时间 */
    var updateTime: String?
    // MARK: - 特有的属性
    /** 主键ID */
    var hotelId: Int?
    /** 对应酒店产品ID */
    var productId: Int?
    /** 房型ID（对应的酒店产品规格ID）*/
    var roomTypeId: Int?
    /** 酒店名称 */
    var hotelName: String?
    /** 酒店所在地（用户输入/行政区域名称） */
    var belongToPlace: String?
    /** 房型（用户输入/酒店规格名称） */
    var roomType: String?
    /** 星级（最终存储的是BIZ_DICT.DICT_ID） */
    var starLevel: String?
    /** 酒店描述 */
    var hotelDesc: String?
    /** 星级名称 */
    var starLevelName: String?
    /** 大于三星级显示 */
    var starBigThree: String?
    
    
    static func decode(_ e: Extractor) throws -> JourenyDetailHotelEntity {
        return try JourenyDetailHotelEntity (
            groupId : e <|? "groupId",
            distanceKM : e <|? "distanceKM",
            travelType : e <|? "travelType",
            travelTime : e <|? "travelTime",
            useTemplateFlag : e <|? "isUseTemplateFlag",
            templateCode : e <|? "templateCode",
            templateText : e <|? "templateText",
            logicRelateion : e <|? "logicRelateion",
            logicRelateionName : e <|? "logicRelateionName",
            createTime : e <|? "createTime",
            updateTime : e <|? "updateTime",
            hotelId : e <|? "hotelId",
            productId : e <|? "productId",
            roomTypeId : e <|? "roomTypeId",
            hotelName : e <|? "hotelName",
            belongToPlace : e <|? "belongToPlace",
            roomType : e <|? "roomType",
            starLevel : e <|? "starLevel",
            hotelDesc : e <|? "hotelDesc",
            starLevelName : e <|? "starLevelName",
            starBigThree : e <|? "starBigThree"
        )
    }

}
