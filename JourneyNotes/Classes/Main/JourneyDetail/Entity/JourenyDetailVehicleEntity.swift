//
//  JourenyDetailVehicleEntity.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation
import Himotoki

struct JourenyDetailVehicleEntity: Himotoki.Decodable {
    
    // MARK: - 共有的属性
    /** 组ID */
    var groupId: Int?
    /** 是否使用话术模板 */
    var useTemplateFlag: String?
    /** 话术模板编号 */
    var templateCode: String?
    /** 创建时间 */
    var createTime: String?
    /** 修改时间 */
    var updateTime: String?
    
    // MARK: - 部分共有的属性
    /** 话术模板文本 */
    var templateText: String?
    // MARK: - 私有的属性
    /** 主键ID */
    var vehicleId: Int?
    /** 交通类型，飞机，火车 */
    var vehicleType: String?
    /** 交通类型Name，飞机，火车 */
    var vehicleName: String?
    /** 交类型为其他时的附加说明 */
    var vehicleOtherInfo: String?
    /** 交通时间 */
    var vehicleTime: String?
    /** 里程数 */
    var vehicleKm: Float?
    /** 是否有接机 */
    var pickUpFlag: String?
    /** 第几天接机 */
    var pickUpDay: Int?
    /** 接（送）机（车）服务描述 7.6 */
    var pickUpDesc: String?
    /** 交通描述 */
    var vehicleDesc: String?
    /** 景点图片url的List */
    var imageUrl: [String]?
    
    static func decode(_ e: Extractor) throws -> JourenyDetailVehicleEntity {
        return try JourenyDetailVehicleEntity (
            groupId : e <|? "groupId",
            useTemplateFlag : e <|? "isUseTemplateFlag",
            templateCode : e <|? "templateCode",
            createTime : e <|? "createTime",
            updateTime : e <|? "updateTime",
            templateText : e <|? "templateText",
            vehicleId : e <|? "vehicleId",
            vehicleType : e <|? "vehicleType",
            vehicleName : e <|? "vehicleName",
            vehicleOtherInfo : e <|? "vehicleOtherInfo",
            vehicleTime : e <|? "vehicleTime",
            vehicleKm : e <|? "vehicleKm",
            pickUpFlag : e <|? "pickUpFlag",
            pickUpDay : e <|? "pickUpDay",
            pickUpDesc : e <|? "pickUpDesc",
            vehicleDesc : e <|? "vehicleDesc",
            imageUrl : e <||? "imageUrl"
        )
    }

}
