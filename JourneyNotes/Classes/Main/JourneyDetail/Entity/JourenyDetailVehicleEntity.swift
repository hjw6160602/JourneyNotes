//
//  JourenyDetailVehicleEntity.swift
//  JourneyNotes
//
//  Created by SaiDicaprio on 2017/8/16.
//  Copyright © 2017年 SaiDicaprio. All rights reserved.
//

import Foundation

struct JourenyDetailVehicleEntity {
    // MARK: - 共有的属性
    /** 组ID */
    var groupId: Int = 0
    /** 是否使用话术模板 */
    var isUseTemplateFlag: Bool = false
    /** 话术模板编号 */
    var templateCode: String = ""
    /** 创建时间 */
    var createTime: String = ""
    /** 修改时间 */
    var updateTime: String = ""
    // MARK: - 部分共有的属性
    /** 话术模板文本 */
    var templateText: String = ""
    // MARK: - 私有的属性
    /** 主键ID */
    var vehicleId: Int = 0
    /** 交通类型，飞机，火车 */
    var vehicleType: Int = 0
    /** 交通类型Name，飞机，火车 */
    var vehicleName: String = ""
    /** 交类型为其他时的附加说明 */
    var vehicleOtherInfo: String = ""
    /** 交通时间 */
    var vehicleTime: String = ""
    /** 里程数 */
    var vehicleKm: Float = 0.0
    /** 是否有接机 */
    var pickUpFlag: String = ""
    /** 第几天接机 */
    var pickUpDay: Int = 0
    /** 接（送）机（车）服务描述 7.6 */
    var pickUpDesc: String = ""
    /** 交通描述 */
    var vehicleDesc: String = ""
}
